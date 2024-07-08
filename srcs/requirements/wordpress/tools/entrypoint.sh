#!/bin/bash
set -e

timeout 30s bash -c 'until nc -z mariadb 3306; do sleep 1; done'

if [ ! -f /var/www/html/wp-config.php ]; then
	cp /wp-config.php /var/www/html/wp-config.php
	sed -i "s/database_name_here/$MYSQL_DATABASE/g" /var/www/html/wp-config.php
	sed -i "s/username_here/$MYSQL_USER/g" /var/www/html/wp-config.php
	sed -i "s/password_here/$MYSQL_PASSWORD/g" /var/www/html/wp-config.php
fi

exec "$@"