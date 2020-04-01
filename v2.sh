#!/bin/bash

if [[ $(/usr/bin/id -u) -ne 0 ]]; then
    echo "请使用root用户或sudo指令執行"
    exit 2
fi

V2_DOMAIN=$1
V2_PATH=$2
CF_EMAIL=$3
CF_APIKEY=$4

apt-get install curl git uuid-runtime coreutils libcap2-bin -y

# install v2ray
bash <(curl -L -s https://install.direct/go.sh)

# install caddy
curl https://getcaddy.com | bash -s personal tls.dns.cloudflare

rm -rf docker-v2ray-caddy-cf
git clone https://github.com/phlinhng/docker-v2ray-caddy-cf.git
cd docker-v2ray-caddy-cf

uuid=$(uuidgen)
sed -i "s/FAKEUUID/${uuid}/g" config.json
sed -i "s/FAKEDOMAIN/${V2_DOMAIN}/g" Caddyfile
sed -i "s/FAKEPATH/${V2_PATH}/g" Caddyfile
sed -i "s/FAKEEMAIL/${CF_EMAIL}/g" caddy.service
sed -i "s/FAKEAPIKEY/${CF_APIKEY}/g" caddy.service

# Give the caddy binary the ability to bind to privileged ports (e.g. 80, 443) as a non-root user
setcap 'cap_net_bind_service=+ep' /usr/local/bin/caddy

# create user for caddy
groupadd -g 33 www-data
useradd -g www-data --no-user-group \
  --home-dir /var/www --no-create-home \
  --shell /usr/sbin/nologin \
  --system --uid 33 www-data
  
mkdir /var/www
chown www-data:www-data /var/www
chmod 555 /var/www

/bin/cp -f config.json /etc/v2ray

mkdir -p /etc/caddy
chown -R root:root /etc/caddy

mkdir -p /etc/ssl/caddy
chown -R root:www-data /etc/ssl/caddy
chmod 0770 /etc/ssl/caddy

/bin/cp Caddyfile /etc/caddy/Caddyfile
chown root:root /etc/caddy/Caddyfile
chmod 644 /etc/caddy/Caddyfile

/bin/cp caddy.service /etc/systemd/system/caddy.service
chown root:root /etc/systemd/system/caddy.service
chmod 644 /etc/systemd/system/caddy.service

systemctl daemon-reload

systemctl enable v2ray
systemctl start v2ray

systemctl enable caddy.service
systemctl start caddy.service

cd ..
rm -rf docker-v2ray-caddy-cf

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
