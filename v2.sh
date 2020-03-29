#!/bin/bash

git clone https://github.com/phlinhng/docker-caddy-v2ray-cf.git
echo "安装docker"
#curl -sSL https://get.docker.com/ | sh
echo "安装docker-compose"
#sudo curl -L "https://github.com/docker/compose/releases/download/1.25.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
#sudo chmod +x /usr/local/bin/docker-compose

#cd docker-caddy-v2ray-cf

read -p "解析到本VPS的域名: " domain
read -p "v2Ray ws路径: " path
read -p "Cloudflare Email: " cfemail
read -p "Cloudflare API KEY: " cfapikey

uuid=$(uuidgen)
sed -i "" "s/FAKEUUID/$uuid/g" ./src/v2ray/config.json
sed -i "" "s/FAKEDOMAIN/$domain/g" ./src/caddy/Caddyfile
sed -i "" "s/FAKEPATH/$path/g" ./src/caddy/Caddyfile
sed -i "" "s/FAKEEMAIL/$cfemail/g" docker-compose.yml
sed -i "" "s/FAKEKEY/$cfapikey/g" docker-compose.yml

#docker-compose up --build -d

echo "Address: $domain"
echo "Port: 443"
echo "UUID: $uuid"
echo "Type: websocket"
echo "Hostname: $domain"
echo "Path: /$path"

exit 0
