
FROM debian:bookworm-slim

RUN apt-get update && apt-get install -y nginx openssl && rm -rf /var/lib/apt/lists/*

COPY ./conf/nginx.conf /etc/nginx/nginx.conf
COPY ./conf/default.conf /etc/nginx/conf.d/default.conf
COPY ./tools/ /etc/ssl/private

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]
