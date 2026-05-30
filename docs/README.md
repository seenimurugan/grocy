# Grocy — household inventory

[Grocy](https://grocy.info) is a self-hosted "ERP for your kitchen" — tracks pantry/fridge/freezer stock, expiry dates, shopping lists, recipes.

## Access

| Where | URL |
|---|---|
| **iPhone / family / TV with Tailscale** | https://grocy.stoat-perch.ts.net |
| **This Mac (browser, cluster DNS)** | http://grocy.homelab.svc.cluster.local |
| **This Mac (localhost via port-forward)** | not configured by default — add to `~/homelab/localhost-portforward.sh` if you want |
| **LAN devices (without Tailscale)** | not configured — see localhost path above |

## Initial credentials

| | |
|---|---|
| User | `admin` |
| Password | `admin` ⚠️ change immediately |

Change on first login: Settings (top right) → Users → Edit admin → Save.

## Detailed docs

- [📋 USAGE](USAGE.md) — daily workflow for your wife (add stock, consume, expiring view, barcode scan)
- [🌟 ADVANCED](ADVANCED.md) — recipes, meal planning, equipment, batteries, API, all the other features
- [🛠 MAINTENANCE](MAINTENANCE.md) — restart, update, backup, troubleshooting
- [🏛 ARCHITECTURE](ARCHITECTURE.md) — tech stack, why SQLite (not Postgres), source location

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
