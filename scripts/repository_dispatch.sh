#!/bin/sh
PAYLOAD="{\"event_type\":\"${EVENT_TYPE}\",\"client_payload\": { \"webhook_data\": ${1}, \"headers\": ${2} }}"

curl -v \
  -H "Accept: application/vnd.github+json" \
  -H "Authorization: Bearer ${GH_TOKEN}"\
  -H "X-GitHub-Api-Version: 2022-11-28" \
  https://api.github.com/repos/${OWNER}/${REPO}/dispatches \
  -d "${PAYLOAD}"

echo "Dispatched"