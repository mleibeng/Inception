FROM debian:11

RUN apt-get update && \
	apt-get install -y redis && \
	apt-get clean && rm -fr /var/lib/apt/lists/*

COPY ./tools/entrypoint.sh /entrypoint.sh

COPY /conf/redis.conf /usr/local/etc/redis/redis.conf

COPY /tools/entrypoint.sh /usr/local/bin/entrypoint.sh

RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

EXPOSE 6379

CMD ["redis-server", "/usr/local/etc/redis/redis.conf"]
