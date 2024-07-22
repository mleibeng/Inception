FROM debian:11

RUN apt-get update && \
	apt-get install -y nginx openssl gettext-base procps && \
	apt-get clean && rm -fr /var/lib/apt/lists/*

COPY /conf/nginx.conf /etc/nginx/nginx.conf
COPY tools/entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

EXPOSE 443

ENTRYPOINT [ "/entrypoint.sh"]