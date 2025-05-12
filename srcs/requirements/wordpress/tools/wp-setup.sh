if ! wp-cli.phar --path=/var/www/html core is-installed;
    then
	wp-cli.phar --path=/var/www/html core download
	wp-cli.phar --path=/var/www/html --skip-check config create \
		--dbname=wordpress --dbuser="$MARIADB_USER" \
        --dbpass="$MARIADB_USER_PASSWORD_FILE" \
		--dbhost=mariadb \
		--dbcharset=utf8mb4 \
		--dbcollate=utf8mb4_general_ci

	wp-cli.phar --path=/var/www/html core install \
		--url=https://jolopez-.42.fr \
		--title=inception \
		--admin_user="$WP_ADMIN_USER" \
		--admin_password="$WP_ADMIN_PASSWORD_FILE" \
		--admin_email="$WP_ADMIN_EMAIL"
	wp-cli.phar --path=/var/www/html user create \
		--role=author "$WP_USER" "$WP_USER_EMAIL" \
		--user_pass="$WP_USER_PASSWORD_FILE"
fi