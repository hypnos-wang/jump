#!/bin/sh

# download files
mkdir -p /etc/caddy /usr/share/caddy
URL="https://raw.githubusercontent.com/hypnos-wang/jump/main/files"
wget -qO /etc/caddy/caddy.conf $URL/caddy.conf
wget -qO /usr/share/caddy/index.html $URL/index.html
wget -qO /jump.json $URL/jump.json
wget -qO /xp $URL/xp
[ ! -e /xp ] && echo "/xp does not exist." && return 1

# set up variables
PORT=443
UUID=$(cat /proc/sys/kernel/random/uuid)
PATH="less"
echo "UUID: $UUID"
echo "PATH: $PATH"
echo "TEST: $TEST"

# replace variables
sed -e "s/\$PATH/$PATH/g" -e "s/\$PORT/$PORT/g" /etc/caddy/caddy.conf
sed -e "s/\$UUID/$UUID/g" -e "s/\$PATH/$PATH/g" /jump.json

# run xp
chmod +x /xp
/xp -config /jump.json &

# run caddy
caddy run --config /etc/caddy/caddy.conf --adapter caddyfile

