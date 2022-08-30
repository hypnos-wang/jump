#!/bin/sh

# set up variables
PORT=443
UUID=$(cat /proc/sys/kernel/random/uuid)
PATH="/less"
echo "UUID: $UUID"
echo "PATH: $PATH"

# replace variables
sed -e "s/\$PATH/$PATH/g" -e "s/\$PORT/$PORT/g" /etc/caddy/caddy.conf
sed -e "s/\$UUID/$UUID/g" -e "s/\$PATH/$PATH/g" /jump.json

# run xp
chmod +x /xp
/xp -config /jump.json &

# run caddy
caddy run --config /etc/caddy/caddy.conf --adapter caddyfile

