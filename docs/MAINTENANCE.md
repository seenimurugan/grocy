# Grocy — Deployment & Maintenance

**On this page:** [Deploy / redeploy](#deploy--redeploy) · [Common operations](#common-operations) · [Credentials](#credentials) · [Backup](#backup) · [Restore](#restore) · [Troubleshooting](#troubleshooting)

## Deploy / redeploy

Config at `~/homelab/grocy-server.yaml` — Deployment + Service + Ingress + PVC. Pre-built image `lscr.io/linuxserver/grocy:latest`.

```bash
kubectl apply -f ~/homelab/grocy-server.yaml
kubectl rollout status deployment/grocy -n homelab
```

## Common operations

### Restart
```bash
kubectl rollout restart deployment/grocy -n homelab
```

### Update to a newer version
```bash
kubectl set image deployment/grocy -n homelab grocy=lscr.io/linuxserver/grocy:latest
kubectl rollout status deployment/grocy -n homelab
```
(LinuxServer's `:latest` tag updates regularly. For pinning, use a specific tag like `lscr.io/linuxserver/grocy:4.5.0`.)

### Logs
```bash
kubectl logs -n homelab deployment/grocy --tail=50
```

### Disk usage
```bash
kubectl exec -n homelab deployment/grocy -- du -sh /config
```

### Change currency (£/$/€)
Currency lives in `/config/data/config.php` on the PVC (Grocy's persistent config — survives pod restarts). Default from the LinuxServer image is `USD`; this homelab runs `GBP`.

```bash
# Set to GBP
kubectl -n homelab exec deploy/grocy -- sed -i "s/Setting('CURRENCY', '[A-Z]*')/Setting('CURRENCY', 'GBP')/" /config/data/config.php
kubectl -n homelab rollout restart deployment/grocy
```

Use any [ISO-4217](https://en.wikipedia.org/wiki/ISO_4217) code (`EUR`, `USD`, `INR`, …).

## Credentials

Initial admin: `admin` / `admin` — change immediately in Settings → Users → Edit admin → Save.

Lost password recovery:
```bash
kubectl exec -n homelab deployment/grocy -- sqlite3 /config/data/grocy.db \
  "UPDATE users SET password='\$2y\$10\$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi' WHERE username='admin'"
```
Password becomes `password`. Log in, change in Settings → Users.

## Backup

The whole `/config` dir contains everything (SQLite DB + uploaded images + plugins).

```bash
BACKUP="/Volumes/Seeni's HDD/grocy-$(date +%Y%m%d-%H%M%S).tar.gz"
kubectl exec -n homelab deployment/grocy -- tar czf - /config | dd of="$BACKUP"
ls -lh "$BACKUP"
```

TODO: integrate into the weekly backup script (`~/homelab/backup-immich.sh` currently only does Immich).

## Restore

Scale Grocy to 0 → untar the backup over the PVC contents → scale back to 1.

```bash
kubectl scale deployment/grocy -n homelab --replicas=0
# Use a debug pod to restore into the PVC
kubectl run grocy-restore --image=busybox -i --rm --tty=false --restart=Never \
  --overrides='{"spec":{"containers":[{"name":"r","image":"busybox","command":["sh","-c","cd /config && tar xzf -"],"stdin":true,"volumeMounts":[{"name":"data","mountPath":"/config"}]}],"volumes":[{"name":"data","persistentVolumeClaim":{"claimName":"grocy-data-pvc"}}]}}' \
  -n homelab < "$BACKUP"
kubectl scale deployment/grocy -n homelab --replicas=1
```

## Troubleshooting

**Page not loading from phone** — Tailscale on phone connected? Then check cluster DNS from Mac to isolate (`curl http://grocy.homelab.svc.cluster.local`).

**Lost admin password** — see "Credentials" above.

**Barcode scan camera fails** — Safari/iOS requires HTTPS for camera. Use `https://grocy.stoat-perch.ts.net`, not the LAN IP (which is HTTP).

**Slow / hangs after big import** — `kubectl top pod -n homelab` to check resource pressure. Bump memory limit in `~/homelab/grocy-server.yaml` if hitting the limit.

**Pod CrashLoopBackOff** — check logs:
```bash
kubectl logs -n homelab deployment/grocy --previous --tail=30
```
Most commonly: PVC not bound (cluster issue) or `/config` ownership wrong (PUID/PGID mismatch — already set to 1000 in YAML).
