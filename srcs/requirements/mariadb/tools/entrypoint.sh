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

max_tries=30
counter=0
until mariadb-admin ping >/dev/null 2>&1 || [$counter -eq $maxtries ]; do
  echo "Waiting for MariaDB to be ready..."
  sleep 1
  counter=$((counter+1))
  echo "Attempt $counter/$max_tries"
done
if [$counter -eq $max_tries ]; then
  echo "Error: MariaDB cannot start up in time"
  exit 1
fi

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