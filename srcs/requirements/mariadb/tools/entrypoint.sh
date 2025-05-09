#!/bin/sh

export MARIADB_ROOT_PASSWORD=$(cat /run/secrets/mariadb_root_pass.txt)
export MARIADB_USER_PASSWORD=$(cat /run/secrets/mariadb_user_pass.txt)

envsubst < /tmp/init.sql > /docker-entrypoint-initdb.d/init.sql

# Llama al comando por defecto de MariaDB
exec su-exec mysql "$@"
