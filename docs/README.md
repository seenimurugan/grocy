# Grocy — household inventory

[Grocy](https://grocy.info) is a self-hosted "ERP for your kitchen" — tracks pantry/fridge/freezer stock, expiry dates, shopping lists, and recipes. Off-the-shelf app, no custom code.

Source: `/Users/nila/Developer/apps/grocy/`

**On this page:** [Access](#access) · [Initial credentials](#initial-credentials) · [What it does](#what-it-does) · [Voice control (Siri Shortcuts)](#voice-control-siri-shortcuts) · [Stack & framework](#stack--framework) · [Storage](#storage) · [See also](#see-also) · [File reference](#file-reference)

---

## Access

| Where | URL |
|---|---|
| **iPhone / family / TV on Tailscale** | https://grocy.stoat-perch.ts.net |
| **Cluster DNS** (other pods / Mac shell) | http://grocy.homelab.svc.cluster.local |
| **Ad-hoc debug port-forward** | `kubectl -n homelab port-forward svc/grocy 8092:80` → http://localhost:8092 |

---

## Initial credentials

| | |
|---|---|
| User | `admin` |
| Password | `admin` |

**Change immediately** on first login: Settings (top right) → Users → Edit admin → Save.

---

## What it does

- Track pantry/fridge/freezer stock with quantities and best-before dates.
- "Expiring soon" / "expired" views to cut food waste.
- One-click consume to decrement stock.
- Barcode scanning (works via phone camera on the web UI).
- Shopping list with automatic addition of below-minimum items.
- Recipes linked to pantry stock.

## Voice control (Siri Shortcuts)

Grocy has a REST API → call it from iPhone Shortcuts → say "Hey Siri, add milk".

1. Grocy → Settings → API keys → **+ Add** → copy
2. iPhone Shortcuts → ＋ → **Get contents of URL**
   - URL: `https://grocy.stoat-perch.ts.net/api/stock/products/<id>/add`
   - Method: POST
   - Headers: `GROCY-API-KEY: <key>`, `Content-Type: application/json`
   - Body: `{"amount": 1, "transaction_type": "purchase"}`
3. **Use with Siri** → record phrase: "Add milk"

Find product IDs at Master Data → Products (URL: `/product/<id>`).

---

## Stack & framework

| Layer | Tech |
|---|---|
| App | Grocy (PHP, by Bernd Bestel) — off-the-shelf, no custom code |
| Container | `lscr.io/linuxserver/grocy:latest` (LinuxServer.io image) |
| Database | SQLite (single file inside `/config/data/grocy.db`) |
| Web server | nginx (built into the LinuxServer image) |
| Deploy | Kubernetes (`homelab` namespace), Tailscale Ingress |

---

## Storage

Single PVC `grocy-data-pvc` on `local-path` (VM ext4, 5 Gi). Holds the entire Grocy config and SQLite database. Back up by copying `/config/data/grocy.db` from the pod.

---

## See also

- [Usage guide](USAGE.md) — daily workflow for your wife (add stock, consume, expiring view, barcode scan)
- [Advanced features](ADVANCED.md) — recipes, meal planning, equipment, batteries, API, all the other features
- [Maintenance](MAINTENANCE.md) — restart, update, backup, troubleshooting
- [Architecture](ARCHITECTURE.md) — tech stack, why SQLite (not Postgres), source location

## File reference

| File | Purpose |
|---|---|
| `/Users/nila/Developer/apps/grocy/k8s/grocy-server.yaml` | Deployment + Service + Ingress + PVC |
