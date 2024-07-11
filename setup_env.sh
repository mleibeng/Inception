#!/bin/bash

ENV_FILE="./srcs/.env"
CREDENTIALS_FILE="./secrets/credentials.txt"

touch "$ENV_FILE"

add_secret_to_env()
{
	local key=$1
	local secret_file=$2
	local value=$(cat "$secret_file")
	echo "$key=$value" >> "$ENV_FILE"
}

> "$ENV_FILE"

echo "DOMAIN_NAME=mleibeng.42.fr" >> "$ENV_FILE"
echo "MYSQL_USER=wordpress_user" >> "$ENV_FILE"
echo "MYSQL_DATABASE=wordpress" >> "$ENV_FILE"

add_secret_to_env "MYSQL_PASSWORD" "./secrets/db_password.txt"
add_secret_to_env "MYSQL_ROOT_PASSWORD" "./secrets/db_root_password.txt"

if [ -f "$CREDENTIALS_FILE" ]; then
	while IFS='=' read -r key value; do
		echo "$key=$value" >> "$ENV_FILE"
	done < "$CREDENTIALS_FILE"
else
	echo "Error: credentials.txt file not found"
	exit 1
fi

echo ".env file has been updated"
