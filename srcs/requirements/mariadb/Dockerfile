FROM debian:bullseye-slim

RUN apt-get update && apt-get install -y \
    mariadb-server \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/run/mysqld \
    && chown -R mysql:mysql /var/lib/mysql /var/run/mysqld \
    && chmod 777 /var/run/mysqld

COPY ./tools/setup.sh /tmp/setup.sh
COPY ./conf/my.cnf /etc/mysql/my.cnf

RUN chmod +x /tmp/setup.sh

VOLUME /var/lib/mysql

EXPOSE 3306

ENTRYPOINT ["/tmp/setup.sh"]
CMD ["mysqld_safe"]
