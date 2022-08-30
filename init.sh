#!/bin/sh

# get user id
UUID=$(cat /proc/sys/kernel/random/uuid)
echo $UUID

# set UUID
sed -e "s/\$UUID/$UUID/g" /caddy.conf
sed -e "s/\$UUID/$UUID/g" /jump.json

# run xp
chmod +x /xp
/xp -config /jump.json &

# run caddy
caddy run --config /etc/caddy/caddy.conf --adapter caddyfile

