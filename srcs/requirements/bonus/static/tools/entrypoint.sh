#!/bin/sh
set -e

if [ ! -f /etc/ssl/certs/nginx.crt ]; then
	openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
	-keyout /etc/ssl/private/nginx.key \
	-out /etc/ssl/certs/nginx.crt \
	-subj "/C=DE/ST=HNN/L=HEILBRONN/O=42/OU=42/CN=${DOMAIN_NAME}"
fi

exec nginx -g 'daemon off;'