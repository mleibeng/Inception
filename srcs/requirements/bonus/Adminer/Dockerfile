FROM debian:11

RUN apt-get update && apt-get install -y \
	php7.4 \
	php7.4-mysql \
	wget \
	&& rm -rf /var/lib/apt/lists/*

RUN wget https://github.com/vrana/adminer/releases/download/v4.8.1/adminer-4.8.1.php -O /var/www/html/index.php

EXPOSE 80

CMD ["php", "-S", "0.0.0.0:80", "-t", "/var/www/html"]