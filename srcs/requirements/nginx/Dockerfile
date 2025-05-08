FROM debian:bookworm-slim

RUN apt-get update && \
    apt-get install -y nginx openssl curl && \
    rm -rf /var/lib/apt/lists/*

COPY ./conf/nginx.conf /etc/nginx/nginx.conf
COPY ./conf/default.conf /etc/nginx/conf.d/default.conf

RUN mkdir -p /var/www/html /var/lib/nginx/body && \
    chown -R www-data:www-data /var/www/html /var/lib/nginx

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]
