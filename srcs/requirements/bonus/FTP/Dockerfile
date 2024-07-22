FROM debian:11

RUN apt-get update && apt-get install -y vsftpd

RUN mkdir -p /var/run/vsftpd/empty

COPY conf/vsftpd.conf /etc/vsftpd.conf
COPY /tools/entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

ARG USER=mleibeng
RUN adduser --disabled-password --gecos "" $USER && usermod -aG www-data $USER

EXPOSE 20 21 21100-21110

CMD ["/entrypoint.sh"]