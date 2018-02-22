#!/bin/sh
# run-perkeep.sh
# Description: create default config and launch perkeep

CONFIG="/config/server-config.json"
KEYRING="/config/identity-secring.gpg"
USERPASS="perkeep:perkeep"

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
    "blobPath": "/storage/blobs",
    "packRelated": true,
    "levelDB": "/storage/index.leveldb"
}
EOT
fi

exec /usr/bin/camlistored -configfile "$CONFIG"
