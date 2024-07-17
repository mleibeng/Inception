#!/bin/bash
set -e

echo "Waiting for MariaDB to be available..."
max_tries=30
counter=0
until nc -z mariadb 3306 || [ $counter -eq $max_tries ]; do
	sleep 2
	counter=$((counter+1))
	echo "Attempt $counter/$max_tries"
done
if [ $counter -eq $max_tries ]; then
  echo "Error: MariaDB did not become available in time"
  exit 1
fi
echo "MariaDB is available."

escape_sed() {
	echo "$1" | sed -e 's/[\/&]/\\&/g'
}

if [ -f /var/www/html/wp-config.php ]; then
	echo "wp-config.php already exists. Deleting it to recreate."
	rm /var/www/html/wp-config.php
fi

echo "Creating wp-config.php from sample."

if cp /var/www/html/wp-config-sample.php /var/www/html/wp-config.php; then
	echo "Copied wp-config-sample.php to wp-config.php"
else
	echo "Failed to copy wp-config-sample.php"
	exit 1
fi

sed -i "s/database_name_here/$(escape_sed "$MYSQL_DATABASE")/g" /var/www/html/wp-config.php || { echo "Failed database sed"; exit 1; }
sed -i "s/username_here/$(escape_sed "$MYSQL_USER")/g" /var/www/html/wp-config.php || { echo "Failed MYSQL_USER sed"; exit 1; }
sed -i "s/password_here/$(escape_sed "$MYSQL_PASSWORD")/g" /var/www/html/wp-config.php || { echo "Failed MYSQL_PASSWORD sed"; exit 1; }
sed -i "s/localhost/mariadb/g" /var/www/html/wp-config.php || { echo "Failed mariadb sed"; exit 1; }

for key in AUTH_KEY SECURE_AUTH_KEY LOGGED_IN_KEY NONCE_KEY AUTH_SALT SECURE_AUTH_SALT LOGGED_IN_SALT NONCE_SALT
do
	new_key=$(openssl rand -base64 64 | tr -d '\n')
	if sed -i "s/define( '$key', *'put your unique phrase here' );/define( '$key', '$(escape_sed "$new_key")' );/" /var/www/html/wp-config.php; then
		echo "Set $key"
	else
		echo "Failed to set $key"
		exit 1
	fi
done

# {
#     echo "define('WP_REDIS_HOST', 'redis');"
#     echo "define('WP_REDIS_PORT', 6379);"
# } >> /var/www/html/wp-config.php

echo "Installing WordPress"
wp core install --path=/var/www/html --url="https://${DOMAIN_NAME}" --title="Just another website" \
	--admin_user="${WP_ADMIN_USER}" --admin_password="${WP_ADMIN_PASSWORD}" --admin_email="${WP_ADMIN_EMAIL}" --allow-root

echo "Starting PHP-FPM"
exec php-fpm7.4 -F
