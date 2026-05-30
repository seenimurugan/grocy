# grocy

Self-hosted household inventory / pantry management — tracks stock, expiry dates, shopping lists, recipes, and more.

## What it does

Track everything in your pantry, fridge, and freezer: add stock with best-before dates, consume with FIFO, get "expiring soon" alerts on the dashboard, barcode-scan from your phone, and build shopping lists with auto-add when stock drops below a minimum. No custom code — Grocy is a battle-tested off-the-shelf app with a full REST API.

## Depends on

- **cluster-setup** — `homelab` namespace, Tailscale ingress controller: [`github.com/seenimurugan/homelab-cluster-setup`](https://github.com/seenimurugan/homelab-cluster-setup)

No shared database needed — Grocy uses a SQLite file stored in its PVC.

## Quick start

```bash
git clone https://github.com/seenimurugan/grocy
cd grocy

# 1. Set up your env
cp .env.example .env
$EDITOR .env   # set HOMELAB_NAMESPACE if not using the default 'homelab'

# 2. Deploy
./deploy.sh
```

`deploy.sh` is idempotent — safe to re-run. It applies the manifest via `envsubst` and waits for rollout.

## Access

| | |
|---|---|
| **Tailnet URL** | https://grocy.stoat-perch.ts.net |
| **Initial login** | `admin` / `admin` — change immediately |
| **Debug port-forward** | `kubectl -n homelab port-forward svc/grocy 8080:80` |
| **In-cluster** | `http://grocy.homelab.svc.cluster.local` |

Change the admin password on first login: Settings (top right) → Users → Edit admin → Save.

## Tear down

```bash
./undeploy.sh              # removes deployment/service/ingress; KEEPS the PVC (data safe)
./undeploy.sh --delete-data  # also deletes the PVC — irreversible
```

## Docs

- [docs/README.md](docs/README.md) — access URLs, initial credentials, Siri Shortcuts
- [docs/USAGE.md](docs/USAGE.md) — daily workflow: add stock, consume, expiry view, barcode scan
- [docs/ADVANCED.md](docs/ADVANCED.md) — recipes, meal planning, equipment, batteries, API, all features
- [docs/MAINTENANCE.md](docs/MAINTENANCE.md) — restart, update, backup, restore, troubleshooting
- [docs/ARCHITECTURE.md](docs/ARCHITECTURE.md) — tech stack, why SQLite (not Postgres), data layout

Also rendered live at https://docs.stoat-perch.ts.net (sidebar → Grocy).
