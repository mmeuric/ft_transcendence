#!/bin/sh
set -e

: "${SLACK_WEBHOOK_URL:?SLACK_WEBHOOK_URL is not set}"

# Render template -> final config
envsubst '${SLACK_WEBHOOK_URL}' \
  < /etc/alertmanager/alertmanager.yml.tpl \
  > /etc/alertmanager/alertmanager.yml

echo "[OK] Rendered /etc/alertmanager/alertmanager.yml"
sed -n '1,120p' /etc/alertmanager/alertmanager.yml

exec /bin/alertmanager \
  --config.file=/etc/alertmanager/alertmanager.yml \
  --storage.path=/alertmanager
