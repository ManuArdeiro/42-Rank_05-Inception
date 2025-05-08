FROM debian:bookworm

# Install PHP + Extensions + WP-CLI
RUN apt-get update && \
    apt-get install -y php php-fpm php-mysql php-curl php-mbstring php-xml php-zip php-gd php-cli curl mariadb-client && \
    curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp && \
    rm -rf /var/lib/apt/lists/*

# PHP-FPM config
COPY conf/php-fpm.conf /etc/php/7.4/fpm/php-fpm.conf
COPY conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf

# WordPress config (will be completed by entrypoint)
COPY conf/wp-config.php /tmp/wp-config.php

# Entrypoint script
COPY tools/entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

WORKDIR /var/www/html

EXPOSE 9000

CMD ["entrypoint.sh"]
