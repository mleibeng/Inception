#!/bin/sh
set -e

if [ ! -f /etc/ssl/certs/nginx.crt ]; then
	openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
	-keyout /etc/ssl/private/nginx.key \
	-out /etc/ssl/certs/nginx.crt \
	-subj "/C=DE/ST=HNN/L=HEILBRONN/O=42/OU=42/CN=${DOMAIN_NAME}"
fi

envsubst '${DOMAIN_NAME}' < /etc/nginx/nginx.conf > /tmp/nginx.conf.tmp

cp /etc/nginx/fastcgi_params /tmp/fastcgi_params
cp /etc/nginx/mime.types /tmp/mime.types

nginx -c /tmp/nginx.conf.tmp -g 'daemon off;'