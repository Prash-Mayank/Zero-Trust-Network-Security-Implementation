#!/usr/bin/env bash
set -euo pipefail

USER_NAME="${1:?username}"
PASS="${2:?password}"
TOTP="${3:-}"
KC="${KC_URL:-http://localhost:8081}"

ARGS=(-s -X POST "$KC/realms/zerotrust/protocol/openid-connect/token"
  -d "client_id=zt-client" -d "grant_type=password"
  -d "username=$USER_NAME" --data-urlencode "password=$PASS")
if [ -n "$TOTP" ]; then ARGS+=(-d "totp=$TOTP"); fi

RESPONSE="$(curl "${ARGS[@]}")"
TOKEN="$(printf '%s' "$RESPONSE" | python3 -c 'import sys,json; d=json.load(sys.stdin); print(d.get("access_token",""))')"

if [ -z "$TOKEN" ]; then
  echo "No token. Server said:" >&2
  echo "$RESPONSE" >&2
  exit 1
fi

echo "$TOKEN"
echo "--- decoded claims ---" >&2
printf '%s' "$TOKEN" | python3 -c '
import sys, json, base64
part = sys.stdin.read().split(".")[1]
part += "=" * (-len(part) % 4)
print(json.dumps(json.loads(base64.urlsafe_b64decode(part)), indent=2))' >&2
