FROM debian:11

RUN apt-get update && apt-get install -y nginx openssl && rm -rf /var/lib/apt/lists/*

COPY index.html /var/www/html/
COPY /tools/entrypoint.sh /entrypoint.sh
COPY /conf/nginx.conf /etc/nginx/conf.d/default.conf

RUN chmod +x /entrypoint.sh

EXPOSE 8081

ENTRYPOINT [ "/entrypoint.sh" ]
