#!/bin/sh

# Generate a self-signed SSL certificate (if not provided)
if [ ! -f /etc/ssl/certs/nginx.crt ] || [ ! -f /etc/ssl/private/nginx.key ]; then
	echo "Generating self-signed SSL certificate..."
	openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
		-keyout /etc/ssl/private/nginx.key \
		-out /etc/ssl/certs/nginx.crt \
		-subj "/CN=localhost"
fi

# Start Nginx in the foreground
nginx -g 'daemon off;'
