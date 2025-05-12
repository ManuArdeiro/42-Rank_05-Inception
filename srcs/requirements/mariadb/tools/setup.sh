#!/bin/bash

set -e

# 1. Configuración de permisos
chown -R mysql:mysql /var/lib/mysql
chmod 750 /var/lib/mysql

# 2. Fuerza inicialización SIEMPRE en primera ejecución
if [ ! -f /var/lib/mysql/.initialized ]; then
    echo "🔧 Initializing database from scratch..."
    
    # Limpieza total
    rm -rf /var/lib/mysql/*
    
    # Instalación del sistema
    mysql_install_db --user=mysql --ldata=/var/lib/mysql
    
    # Inicio temporal
    mysqld_safe --user=mysql --datadir=/var/lib/mysql --socket=/tmp/mysql.sock &
    sleep 5
    
    # Configuración
    ROOT_PASS=$(tr -d '\n\r' < ${MARIADB_ROOT_PASSWORD_FILE})
    USER_PASS=$(tr -d '\n\r' < ${MARIADB_PASSWORD_FILE})
    ADMIN_PASS=$(tr -d '\n\r' < ${MARIADB_ADMIN_PASSWORD_FILE})
    
    mysql -uroot --socket=/tmp/mysql.sock <<SQL
CREATE DATABASE IF NOT EXISTS ${MARIADB_DATABASE};
CREATE USER '${MARIADB_USER}'@'%' IDENTIFIED BY '${USER_PASS}';
GRANT ALL ON ${MARIADB_DATABASE}.* TO '${MARIADB_USER}'@'%';
CREATE USER '${MARIADB_ADMIN_USER}'@'%' IDENTIFIED BY '${ADMIN_PASS}';
GRANT ALL PRIVILEGES ON *.* TO '${MARIADB_ADMIN_USER}'@'%' WITH GRANT OPTION;
FLUSH PRIVILEGES;
ALTER USER 'root'@'localhost' IDENTIFIED BY '${ROOT_PASS}';
SQL

    # Marcar como inicializado
    touch /var/lib/mysql/.initialized
    
    # Detener servidor temporal
    mysqladmin -uroot -p${ROOT_PASS} --socket=/tmp/mysql.sock shutdown
    sleep 3
fi

# 3. Inicio normal
exec mysqld_safe --user=mysql --datadir=/var/lib/mysql