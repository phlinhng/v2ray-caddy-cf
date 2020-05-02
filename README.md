# v2Ray Caddy Cloudflare 一键脚本
利用`docker`实现的v2Ray一键脚本，集成Cloudflare API，无需手动点灰云朵也能自动获取证书。

# 用法
```sh
wget https://raw.githubusercontent.com/phlinhng/v2ray-caddy-cf/docker/v2.sh && chmod +x v2.sh && ./v2.sh
```
适用ubuntu, debian系统

# 配置示范
執行脚本后需要输入以下信息
```sh
解析到本VPS的域名: www.yourdomain.com
v2Ray ws路径: /yourpath
Cloudflare Email: johndoe@gmail.com
Cloudflare API KEY: a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3
```
安装成功后会显示如下的配置信息 (UUID为随机生成，每次皆不同；Alter ID默认为6)
```sh
Address: www.yourdomain.com
Port: 443
UUID: 13FB0A64-3BC8-4574-8D49-7121B04BDE83
Alter ID: 0
Type: websocket
Hostname: www.yourdomain.com
Path: /yourpath

vmess://eyJhZGQiOiJhYmMuY29tIiwiYWlkIjoiMzYiLCJob3N0IjoiYWJjLmNvbSIsImlkIjoiRDA0RTczODEtN0Y5Qi00OEYyLTg2QzMtOTQwRjBCNTQ3MEEwIiwibmV0Ijoid3MiLCJwYXRoIjoiL2FiYyIsInBvcnQiOiI0NDMiLCJwcyI6ImFiYy5jb206NDQzIiwidGxzIjoidGxzIiwidHlwZSI6Im5vbmUiLCJ2IjoiMiJ9Cg==
```

# 修改配置重新启动
若配置填写错误造成服务异常，可以手动修改以下档案的配置后重新启动
+ 域名,路径 : `v2ray-caddy-cf/src/caddy/Caddyfile`
+ Cloudflare Email, Cloudflare API Key: `v2ray-caddy-cf/docker-compose.yml`    
修改后执行`sudo docker-compose up --build`重启

# 安装 BBR四合一加速脚本
```sh
sudo wget -N --no-check-certificate "https://raw.githubusercontent.com/chiakge/Linux-NetSpeed/master/tcp.sh" && chmod +x tcp.sh && ./tcp.sh
```



