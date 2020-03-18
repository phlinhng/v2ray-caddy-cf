FROM ubuntu:18.04

RUN apt-get update && apt-get upgrade -y
RUN apt-get install curl -y
RUN curl https://getcaddy.com | bash -s personal tls.dns.cloudflare
COPY Caddyfile /etc/Caddyfile