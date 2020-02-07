#!/usr/bin/env bash
set -e

### Generate polkit local authority override 
### Reference: https://c-nergy.be/blog/?p=12043

test $(id -u) -eq 0 || { echo "Must be run as root"; exit 1; }

PK_LOCAL_AUTH_DIR=/etc/polkit-1/localauthority/50-local.d

mkdir -p $PK_LOCAL_AUTH_DIR
cat <<EOF > $PK_LOCAL_AUTH_DIR/45-allow-colord.pkla
[Allow Colord all Users]
Identity=unix-user:*
Action=org.freedesktop.color-manager.create-device;org.freedesktop.color-manager.create-profile;org.freedesktop.color-manager.delete-device;org.freedesktop.color-manager.delete-profile;org.freedesktop.color-manager.modify-device;org.freedesktop.color-manager.modify-profile
ResultAny=no
ResultInactive=no
ResultActive=yes
EOF
echo "PolKit local authority file created successfully"