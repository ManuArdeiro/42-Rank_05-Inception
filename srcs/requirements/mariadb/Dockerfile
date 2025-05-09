# ───────── MariaDB ─────────

FROM debian:bookworm-slim

RUN apt update -y && apt upgrade -y

RUN apt-get install -y mariadb-server mariadb-client curl procps gettext gosu && \
    rm -rf /var/lib/apt/lists/*

COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
COPY ./tools/init.sql.template /etc/mysql/init.sql
COPY ./tools/entrypoint.sh /usr/local/bin/entrypoint.sh

RUN chmod +x /usr/local/bin/entrypoint.sh && \
    mkdir -p /docker-entrypoint-initdb.d /var/run/mysqld /var/log/mysql && \
    chown -R mysql:mysql /var/run/mysqld /var/lib/mysql /docker-entrypoint-initdb.d/ /var/log/mysql && \
    chmod 755 /var/run/mysqld

EXPOSE 3306

USER mysql

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["mysqld"]

