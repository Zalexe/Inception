# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: cmarrued <marvin@42.fr>                    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2026/02/14 18:36:50 by cmarrued          #+#    #+#              #
#    Updated: 2026/02/14 18:36:51 by cmarrued         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM debian:12

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

COPY tools/wp-setup.sh /usr/bin/

RUN chmod +x /usr/bin/wp-setup.sh

EXPOSE 9000

ENTRYPOINT [ "wp-setup.sh" ]
