# ───────── MariaDB ─────────

FROM debian:bookworm-slim

ARG WP_DATABASE_USER
ARG WP_DATABASE_USER_PASSWORD
ARG MARIADB_ROOT_PASSWORD

ENV WP_DATABASE_USER=${WP_DATABASE_USER} \
    WP_DATABASE_USER_PASSWORD=${WP_DATABASE_USER_PASSWORD} \
    MARIADB_ROOT_PASSWORD=${MARIADB_ROOT_PASSWORD}

RUN apt-get update && \
    apt-get install -y mariadb-server mariadb-client curl procps gettext && \
    rm -rf /var/lib/apt/lists/*

COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
COPY ./tools/init.sql /tmp/init.sql
COPY ./tools/entrypoint.sh /usr/local/bin/entrypoint.sh

RUN chmod +x /usr/local/bin/entrypoint.sh && \
    mkdir -p /docker-entrypoint-initdb.d /var/run/mysqld && \
    envsubst < /tmp/init.sql > /docker-entrypoint-initdb.d/init.sql && \
    chown -R mysql:mysql /var/run/mysqld /var/lib/mysql && \
    chmod 755 /var/run/mysqld

EXPOSE 3306

USER mysql

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["mysqld"]
