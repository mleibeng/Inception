FROM debian:11

RUN apt-get update && \
	apt-get install -y mariadb-server && \
	apt-get clean && rm -fr /var/lib/apt/lists/* && \
	mkdir -p /run/mysqld && \
	chown mysql:mysql /run/mysqld

COPY conf/my.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
COPY tools/entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

EXPOSE 3306

ENTRYPOINT ["/entrypoint.sh"]
