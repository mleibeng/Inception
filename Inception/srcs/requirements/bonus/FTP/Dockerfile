
FROM debian:11

RUN apt-get update && \
	apt-get install -y vsftpd && \
	rm -rf /var/lib/apt/lists/*

COPY conf/vsftpd.conf /etc/vsftpd.conf

COPY tools/entrypoint.sh /usr/local/bin/entrypoint.sh

COPY ../../../.env /root/.env

RUN chmod +x /usr/local/bin/entrypoint.sh

EXPOSE 20 21 21100-21110

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]