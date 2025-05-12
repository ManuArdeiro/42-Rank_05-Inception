#!/bin/bash

WP_PATH="/var/www/html"

echo "Ajustando permisos..."
chown -R www-data:www-data /var/www/html
chown -R www-data:www-data "$WP_PATH"

# Waiting for mariadb
echo "Esperando a MariaDB..."
while ! mariadb -h mariadb -u "$WP_DATABASE_USER" -p"$(cat $MARIADB_USER_PASS_FILE)" -e "SELECT 1;" &> /dev/null;
    do 
    sleep 2
done
echo "MariaDB listo."

# Download WordPress (if not)
if [ ! -f "$WP_PATH/wp-config.php" ];
    then 
    echo "Instalando WordPress..."
    wp --allow-root --path="$WP_PATH" core download
fi

# Crear wp-config.php si no existe
if [ ! -f "$WP_PATH/wp-config.php" ];
    then
    echo "Creando wp-config.php..."
    wp --allow-root --path="$WP_PATH" config create \
        --dbname="$WP_DATABASE" \
        --dbuser="$WP_DATABASE_USER" \
        --dbpass="$(cat $MARIADB_USER_PASS_FILE)" \
        --dbhost="mariadb" \
        --dbprefix="wp_"
fi

# Instalar WordPress si no está instalado
if ! wp --allow-root --path="$WP_PATH" core is-installed;
    then
    echo "Instalando WordPress..."
    wp --allow-root --path="$WP_PATH" core install \
        --url="$WP_URL" \
        --title="$WP_TITLE" \
        --admin_user="$WP_ADMIN_USER" \
        --admin_password="$(cat $WP_ADMIN_PASS_FILE)" \
        --admin_email="$WP_ADMIN_EMAIL"
fi

# Crear usuario secundario si no existe
if ! wp --allow-root --path="$WP_PATH" user get "$WP_USER" &> /dev/null;
    then
    echo "Creando usuario adicional..."
    wp --allow-root --path="$WP_PATH" user create "$WP_USER" "$WP_USER_EMAIL" \
        --user_pass="$(cat $WP_USER_PASS_FILE)" \
        --role="$WP_USER_ROLE"
fi

# Iniciar PHP-FPM
exec php-fpm -F
