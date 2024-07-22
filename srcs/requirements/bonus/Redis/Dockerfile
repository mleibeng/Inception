FROM debian:11

RUN apt-get update && \
	apt-get install -y redis && \
	apt-get clean && rm -fr /var/lib/apt/lists/*

COPY ./tools/entrypoint.sh /entrypoint.sh

COPY /conf/redis.conf /etc/redis/redis.conf

RUN chmod +x /entrypoint.sh

EXPOSE 6379

ENTRYPOINT ["/entrypoint.sh"]
