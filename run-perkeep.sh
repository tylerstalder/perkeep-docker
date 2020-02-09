#!/bin/sh
# run-perkeep.sh
# Description: create default config and launch perkeep

CONFIG="/config/server-config.json"
KEYRING="/config/identity-secring.gpg"
USERPASS="perkeep:perkeep"

export GOOGLE_APPLICATION_CREDENTIALS="/config/gcp-service-account.json"

set -e

if test ! -f "$CONFIG" -a ! -f "$KEYRING"; then
  echo "$0: Creating $KEYRING"
  KEY="$(/usr/bin/genkey -secring "$KEYRING")"
  echo "$0: New key ID: $KEY"
  echo "$0: Creating $CONFIG"
  echo "$0: Initial user:passwd is $USERPASS - please change it!"
cat >"$CONFIG" << EOT
{
    "auth": "userpass:$USERPASS",
    "listen": ":3179",
    "baseURL": "",
    "camliNetIP": "",
    "identity": "$KEY",
    "identitySecretRing": "$KEYRING",
    "googlecloudstorage": ":bucket-name/blobs",
    "packRelated": true,
    "levelDB": "/storage/index.leveldb"
}
EOT
fi

exec /usr/bin/perkeepd -configfile "$CONFIG"
