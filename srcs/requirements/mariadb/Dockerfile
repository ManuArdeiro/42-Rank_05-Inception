
FROM debian:bookworm-slim

RUN apt-get update && apt-get install -y mariadb-server mariadb-client && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/run/mysqld && chown -R mysql:mysql /var/run/mysqld /var/lib/mysql && chmod 755 /var/run/mysqld

COPY ./conf/my.cnf /etc/mysql/my.cnf
COPY ./tools/init.sql /docker-entrypoint-initdb.d/init.sql

EXPOSE 3306

CMD ["mysqld"]
