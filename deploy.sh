#!/usr/bin/env bash
# deploy.sh — idempotent deploy for grocy (household inventory)
# Usage: ./deploy.sh
# Safe to re-run; existing resources are patched, not replaced.
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# ── 1. Load .env ─────────────────────────────────────────────────────────────
ENV_FILE="$SCRIPT_DIR/.env"
if [[ ! -f "$ENV_FILE" ]]; then
  echo "ERROR: .env not found."
  echo "       Copy .env.example to .env and fill in real values, then re-run."
  echo "         cp .env.example .env && \$EDITOR .env"
  exit 1
fi
# shellcheck disable=SC1090
set -a; source "$ENV_FILE"; set +a

# ── 2. Prereq checks ─────────────────────────────────────────────────────────
if ! command -v kubectl &>/dev/null; then
  echo "ERROR: kubectl not found in PATH."
  exit 1
fi
if ! command -v envsubst &>/dev/null; then
  echo "ERROR: envsubst not found. Install via: brew install gettext"
  exit 1
fi
if ! kubectl cluster-info &>/dev/null; then
  echo "ERROR: Cannot reach the Kubernetes cluster. Is OrbStack running?"
  exit 1
fi

# ── 3. Ensure namespace exists ───────────────────────────────────────────────
HOMELAB_NAMESPACE="${HOMELAB_NAMESPACE:-homelab}"
if ! kubectl get namespace "$HOMELAB_NAMESPACE" &>/dev/null; then
  echo "Namespace '$HOMELAB_NAMESPACE' not found — creating it."
  kubectl create namespace "$HOMELAB_NAMESPACE"
else
  echo "Namespace '$HOMELAB_NAMESPACE' already exists."
fi

# ── 4. Apply manifests via envsubst ──────────────────────────────────────────
K8S_DIR="$SCRIPT_DIR/k8s"
echo "Applying k8s manifests (envsubst → kubectl apply)..."
echo "  → $K8S_DIR/grocy-server.yaml"
envsubst < "$K8S_DIR/grocy-server.yaml" | kubectl apply -f -

# ── 5. Wait for rollout ───────────────────────────────────────────────────────
echo "Waiting for grocy rollout..."
kubectl -n "$HOMELAB_NAMESPACE" rollout status deployment/grocy --timeout=5m

# ── 6. Done ───────────────────────────────────────────────────────────────────
echo ""
echo "✓ grocy deployed successfully."
echo ""
echo "  Access (on Tailnet):    https://grocy.stoat-perch.ts.net"
echo "  Initial login:          admin / admin"
echo ""
echo "  Change the admin password immediately on first deploy:"
echo "  Settings (top right) → Users → Edit admin → Save"
echo "  See docs/MAINTENANCE.md for full maintenance guide."
