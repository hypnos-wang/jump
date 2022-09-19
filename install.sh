#!/bin/bash

if [ "$UUID" = "" ]; then
	UUID=$(cat /proc/sys/kernel/random/uuid)
fi

WSPATH="less"
echo "UUID: $UUID"
echo "PATH: $WSPATH"

cat > /root/xp.json << EOF
{
    "inbounds": 
    [
        {
	    "port": 10000,
            "listen": "0.0.0.0",
            "protocol": "vless",
            "settings": {"clients": [{"id": "$UUID"}],"decryption": "none"},
            "streamSettings": {"network": "ws","wsSettings": {"path": "$WSPATH"}}
        }
    ],  
    "outbounds": 
    [
        {"protocol": "freedom","tag": "direct","settings": {}}
    ]  
}
EOF

if [ "$(command -v nginx)" = "" ]; then
	apt -y install nginx
fi

if [ ! -e /root/xp ]; then
	curl -L https://github.com/hugo-on/jump/raw/main/files/nginx.conf > /etc/nginx/sites-enabled/default
	curl -L https://github.com/hugo-on/jump/raw/main/files/index.html > /var/www/html/index.html
	curl -L https://github.com/hugo-on/jump/raw/main/files/xp > /root/xp && chmod +x /root/xp
fi

nginx -s reload || nginx
nohup /root/xp --config /root/xp.json &

if ! grep xp /root/.bashrc > /dev/null; then
	cat >> /root/.bashrc << EOF
if [ "$(pidof nginx)" != "" ]; then
        echo "nginx ok"
else
        echo "run nginx..."
        nginx
        echo "done"
fi
if [ "$(pidof xp)" != "" ]; then
        echo "xp ok"
else
        echo "run xp..."
        nohup /root/xp --config /root/xp.json &
        echo "done"
fi
EOF
fi
echo "all done."

