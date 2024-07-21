FROM debian:11

RUN apt-get update && apt-get install -y nginx openssl && rm -rf /var/lib/apt/lists/*

COPY index.html /var/www/html/

COPY /conf/nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 8443

CMD ["nginx", "-g", "daemon off;"]
