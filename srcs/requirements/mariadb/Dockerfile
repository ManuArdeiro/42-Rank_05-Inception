# ───────── MariaDB ─────────

FROM debian:bookworm-slim

RUN apt-get update && \
    apt-get install -y mariadb-server mariadb-client curl procps && \
    rm -rf /var/lib/apt/lists/*

COPY ./conf/custom.cnf /etc/mysql/mariadb.conf.d/50-custom.cnf

COPY ./tools/init.sql /docker-entrypoint-initdb.d/init.sql

RUN mkdir -p /var/run/mysqld && \
    chown -R mysql:mysql /var/run/mysqld /var/lib/mysql && \
    chmod 755 /var/run/mysqld

EXPOSE 3306

CMD ["mysqld"]

