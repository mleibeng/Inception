FROM debian:11

RUN apt-get update && \
	apt-get install -y php7.4-fpm php7.4-mysql \
	php7.4-curl php7.4-gd php7.4-intl \
	php7.4-mbstring php7.4-soap php7.4-xml php7.4-zip \
	iputils-ping redis-server php7.4-redis ftp \
	wget mariadb-client netcat && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/*

RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
	chmod +x wp-cli.phar && \
	mv wp-cli.phar /usr/local/bin/wp

WORKDIR /var/www/html

RUN wget https://wordpress.org/latest.tar.gz && \
	tar -xzvf latest.tar.gz --strip-components=1 && \
	rm latest.tar.gz && \
	chown -R www-data:www-data /var/www/html

COPY conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf
COPY tools/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
RUN mkdir -p /run/php
RUN chown www-data:www-data /run/php
EXPOSE 9000
ENTRYPOINT [ "/entrypoint.sh"]