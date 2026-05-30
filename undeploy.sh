#!/usr/bin/env bash
# undeploy.sh — tear down grocy deployments/services/ingress/PVC
# NOTE: By default the PVC (grocy-data-pvc) is NOT deleted — your SQLite DB survives.
#       Pass --delete-data to also delete the PVC (irreversible).
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# ── Load .env for HOMELAB_NAMESPACE ──────────────────────────────────────────
ENV_FILE="$SCRIPT_DIR/.env"
if [[ -f "$ENV_FILE" ]]; then
  # shellcheck disable=SC1090
  set -a; source "$ENV_FILE"; set +a
fi
HOMELAB_NAMESPACE="${HOMELAB_NAMESPACE:-homelab}"

DELETE_DATA=false
for arg in "$@"; do
  [[ "$arg" == "--delete-data" ]] && DELETE_DATA=true
done

echo "Undeploying grocy from namespace '$HOMELAB_NAMESPACE'..."
if $DELETE_DATA; then
  echo "WARNING: --delete-data specified — PVC will also be deleted. Data is NOT recoverable."
fi
echo ""

# ── Deployments ───────────────────────────────────────────────────────────────
kubectl -n "$HOMELAB_NAMESPACE" delete deployment grocy --ignore-not-found

# ── Services ──────────────────────────────────────────────────────────────────
kubectl -n "$HOMELAB_NAMESPACE" delete service grocy --ignore-not-found

# ── Ingress ───────────────────────────────────────────────────────────────────
kubectl -n "$HOMELAB_NAMESPACE" delete ingress grocy --ignore-not-found

# ── PVC (optional) ────────────────────────────────────────────────────────────
if $DELETE_DATA; then
  echo "Deleting PVC grocy-data-pvc (and all Grocy data)..."
  kubectl -n "$HOMELAB_NAMESPACE" delete pvc grocy-data-pvc --ignore-not-found
fi

echo ""
echo "✓ Grocy torn down."
echo ""
if $DELETE_DATA; then
  echo "  Data deleted: grocy-data-pvc removed."
else
  echo "  Kept (data):"
  echo "    - grocy-data-pvc PVC (SQLite DB + config intact)"
  echo ""
  echo "  To delete data too:  ./undeploy.sh --delete-data"
fi
echo ""
echo "  To redeploy:  ./deploy.sh"
