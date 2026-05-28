#!/bin/bash
# Export a LGND collection to GeoParquet in your S3 bucket.
#
# Setup (one-time):
#   1. Grant your IAM role read access:
#      curl -X PUT -H "Authorization: Bearer $LGND_API_KEY" -H "Content-Type: application/json" \
#        -d '{"principal_arns": ["arn:aws:iam::YOUR_ACCOUNT:role/YOUR_ROLE"]}' \
#        https://embeddings.api.lgnd.ai/v1/exports/destination/principals
#
# Usage:
#   export LGND_API_KEY=sk_...
#   ./export_collection.sh <tenant_id> <collection_id>

API="https://embeddings.api.lgnd.ai/v1"
AUTH=(-H "Authorization: Bearer ${LGND_API_KEY:?Set LGND_API_KEY}")

BUCKET=$(curl -sf "${AUTH[@]}" "$API/exports/destination" | jq -r .bucket_name)
EXPORT=$(curl -sf -X POST "${AUTH[@]}" -H "Content-Type: application/json" -d '{}' "$API/tenants/$1/collections/$2/exports")

echo "Export $(echo $EXPORT | jq -r .id) started."
echo "Check status: curl -H 'Authorization: Bearer \$LGND_API_KEY' $API/tenants/$1/collections/$2/exports/$(echo $EXPORT | jq -r .id)"
echo "Data will appear at: s3://$BUCKET/$(echo $EXPORT | jq -r '.tenant_id + "/" + .collection_id')/"
