TOKEN="$1"
KEY_GUID=$2

RESOURCE_KEY=$(
    curl -s -X GET \
        https://resource-controller.cloud.ibm.com/v2/resource_keys/$KEY_GUID \
        -H "Authorization: $TOKEN"
)

ACCESS_KEY_ID=$(echo $RESOURCE_KEY | jq -r ".credentials.cos_hmac_keys.access_key_id")
SECRET_ACCESS_KEY=$(echo $RESOURCE_KEY | jq -r ".credentials.cos_hmac_keys.secret_access_key")

jq -n '{
    "access_key_id" : "'$ACCESS_KEY_ID'",
    "secret_access_key" : "'$SECRET_ACCESS_KEY'"
}'