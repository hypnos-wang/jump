#!/bin/sh

# set up variables
# PORT=443
if [ "$UUID" = "" ]; then
  UUID=$(cat /proc/sys/kernel/random/uuid)
fi
WSPATH="less"
echo "UUID: $UUID"
echo "PATH: $WSPATH"
echo "PORT: $PORT"

# replace variables
sed -i -e "s/\$PATH/\/$WSPATH/g" -e "s/\$PORT/$PORT/g" /etc/caddy/Caddyfile
sed -i -e "s/\$UUID/$UUID/g" -e "s/\$PATH/\/$WSPATH/g" /jump.json

# run xp
chmod +x /xp
/xp -config /jump.json &

# run caddy
caddy run --config /etc/caddy/Caddyfile --adapter caddyfile

