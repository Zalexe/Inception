FROM debian:bullseye

RUN apt-get update && apt-get install -y \
	php7.4 \
	php7.4-fpm \
	php7.4-mysql \
	curl \
	mariadb-client \
	&& rm -rf /var/lib/apt/lists/*

RUN mkdir -p /run/php

COPY tools/wp-setup.sh /wp-setup.sh
RUN chmod +x /wp-setup.sh

WORKDIR /var/www/html

EXPOSE 9000

ENTRYPOINT ["/wp-setup.sh"]
CMD ["php-fpm7.4", "-F"]
