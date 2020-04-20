# v2Ray Caddy Cloudflare 一键脚本
利用官方腳本实现的v2Ray干净一键脚本，集成Cloudflare API，无需手动点灰云朵也能自动获取证书。

## [Docker 版](https://github.com/phlinhng/v2ray-caddy-cf/tree/docker)

# 用法
## 初次安装
```sh
wget -N --no-check-certificate https://raw.githubusercontent.com/phlinhng/v2ray-caddy-cf/master/v2.sh && chmod +x v2.sh && ./v2.sh [domain] [path] [cloudflare email] [cloudflare api key]
```
## 更新 v2Ray
```sh
bash <(curl -L -s https://install.direct/go.sh)
```
适用ubuntu, debian系统

# 示范
```sh
./v2.sh "www.yourdomain.com" "yourpath" "johndoe@gmail.com" "a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3"
```
安装成功后会显示如下的配置信息 (UUID为随机生成，每次皆不同；Alter ID默认为0)
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

# 注意事项
请确保配置信息填写正确。

# 安装 BBR四合一加速脚本
```sh
sudo wget -N --no-check-certificate "https://raw.githubusercontent.com/chiakge/Linux-NetSpeed/master/tcp.sh" && chmod +x tcp.sh && ./tcp.sh
```



