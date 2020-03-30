#!/bin/bash

if [[ $(/usr/bin/id -u) -ne 0 ]]; then
    echo "请使用root用户或sudo指令執行"
    exit
fi

apt-get install curl -y
# install v2ray
bash <(curl -L -s https://install.direct/go.sh)

# install caddy
curl https://getcaddy.com | bash -s personal tls.dns.cloudflare

rm -rf docker-v2ray-caddy-cf
git clone https://github.com/phlinhng/docker-v2ray-caddy-cf.git
cd docker-v2ray-caddy-cf && git checkout env
export $(xargs <.env)

uuid=$(uuidgen)
sed -i "s/FAKEUUID/${uuid}/g" config.json
sed -i "s/FAKEDOMAIN/${V2_DOMAIN}/g" Caddyfile
sed -i "s/FAKEPATH/${V2_PATH}/g" Caddyfile
sed -i "s/FAKEEMAIL/${CF_EMAIL}/g" caddy.service
sed -i "s/FAKEAPIKEY/${CF_APIKEY}/g" caddy.service

groupadd --system caddy
useradd --system \
           --gid caddy \
           --create-home \
           --home-dir /var/lib/caddy \
           --shell /usr/sbin/nologin \
           --comment "Caddy web server" \
           caddy

/bin/cp -f config.json /etc/v2ray
mkdir -p /etc/caddy
chown -R caddy:caddy /etc/caddy
mkdir -p /etc/ssl/caddy
chown -R caddy:caddy /etc/ssl/caddy
/bin/cp Caddyfile /etc/caddy/Caddyfile
/bin/cp caddy.service /etc/systemd/system

systemctl enable v2ray
systemctl start v2ray

systemctl enable caddy.service
systemctl start caddy.service


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
