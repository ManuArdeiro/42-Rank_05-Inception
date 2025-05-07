
FROM debian:bookworm-slim

RUN apt-get update && apt-get install -y php php-fpm php-mysql curl wget unzip && rm -rf /var/lib/apt/lists/*

RUN id -u www-data || adduser --system --group www-data

RUN mkdir -p /var/www/html

WORKDIR /var/www/html

RUN curl -O https://wordpress.org/latest.tar.gz && tar -xzf latest.tar.gz && cp -r wordpress/* . && rm -rf wordpress latest.tar.gz

RUN chown -R www-data:www-data /var/www/html && chmod -R 755 /var/www/html

COPY ./conf/php-fpm.conf /etc/php/8.2/fpm/php-fpm.conf
COPY ./conf/www.conf /etc/php/8.2/fpm/pool.d/www.conf

EXPOSE 9000

CMD ["php-fpm8.2", "-F"]
