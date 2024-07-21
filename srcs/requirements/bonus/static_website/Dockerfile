FROM debian:11

RUN apt-get update && apt-get install -y nginx openssl && rm -rf /var/lib/apt/lists/*

COPY index.html /var/www/html/

COPY /conf/nginx.conf /etc/nginx/conf.d/default.conf

COPY /tools/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 8443

ENTRYPOINT ["/entrypoint.sh"]
