#!/bin/bash
set -e

if [ ! -d "/var/lib/mysql/mysql" ]; then
	mkdir -p /var/lib/mysql
	chown -R mysql:mysql /var/lib/mysql
	mariadb-install-db --user=mysql --datadir=/var/lib/mysql
fi

mkdir -p /run/mysqld
chown -R mysql:mysql /run/mysqld

/usr/sbin/mariadbd --user=mysql &

until mariadb-admin ping >/dev/null 2>&1; do
  echo "Waiting for MariaDB to be ready..."
  sleep 1
done

if [ ! -d "/var/lib/mysql/${MYSQL_DATABASE}" ]; then
	echo "Initializing database..."

	mariadb -e "CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};"
	mariadb -e "CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';"
	mariadb -e "GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';"
	mariadb -e "FLUSH PRIVILEGES;"

	mariadb-admin -u root password "${MYSQL_ROOT_PASSWORD}"
fi

mariadb-admin -u root -p"${MYSQL_ROOT_PASSWORD}" shutdown

exec mariadbd --user=mysql