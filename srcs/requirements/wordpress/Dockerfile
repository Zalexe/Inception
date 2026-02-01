FROM debian:11.11

RUN apt-get update && \
    apt-get install -y \
        php-fpm \
        php-mysql \
        php-curl \
        php-gd \
        php-mbstring \
        php-xml \
        php-xmlrpc \
        php-soap \
        php-intl \
        php-zip \
        php-imagick \
        wget \
        curl \
        unzip \
        mariadb-client && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /var/www/html

RUN chown -R www-data:www-data /var/www/html

RUN curl -o /usr/local/bin/wp https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x /usr/local/bin/wp

RUN sed -i 's/listen = \/run\/php\/php8.2-fpm.sock/listen = 9000/' /etc/php/8.2/fpm/pool.d/www.conf

COPY tools/script.sh /usr/bin/

RUN chmod +x /usr/bin/script.sh

EXPOSE 9000

ENTRYPOINT [ "wp-setup.sh" ]