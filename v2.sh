#!/bin/bash

if [[ $(/usr/bin/id -u) -ne 0 ]]; then
    echo "请使用root用户或sudo指令執行"
    exit
fi

apt-get install curl git uuid-runtime -y
curl -sSL https://get.docker.com/ | sh
curl -L "https://github.com/docker/compose/releases/download/1.25.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

rm -rf docker-v2ray-caddy-cf
git clone https://github.com/phlinhng/docker-v2ray-caddy-cf.git
cd docker-v2ray-caddy-cf
git checkout env
export $(xargs <.env)

uuid=$(uuidgen)
sed -i "s/FAKEUUID/$uuid/g" ./src/v2ray/config.json

docker-compose up --build -d

echo ""
echo "Address: ${V2_DOMAIN}"
echo "Port: 443"
echo "UUID: ${uuid}"
echo "Alter ID: 6"
echo "Type: websocket"
echo "Hostname: ${V2_DOMAIN}"
echo "Path: /${V2_PATH}"
echo ""

json="{\"add\":\"${V2_DOMAIN}\",\"aid\":\"36\",\"host\":\"${V2_DOMAIN}\",\"id\":\"${uuid}\",\"net\":\"ws\",\"path\":\"/${V2_PATH}\",\"port\":\"443\",\"ps\":\"${V2_DOMAIN}:443\",\"tls\":\"tls\",\"type\":\"none\",\"v\":\"2\"}"

uri="$(echo "${json}" | base64)"
echo "vmess://${uri}"

exit 0
