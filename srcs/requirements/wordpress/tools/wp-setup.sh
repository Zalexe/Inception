#!/bin/sh
set -e
cd /var/www/html

if [ ! -f "wp-load.php" ]; then
    echo "Downloading WordPress..."
    wp core download --allow-root
else
    echo "WordPress files already present."
fi

if ! wp core is-installed --allow-root 2>/dev/null; then
    echo "Installing WordPress..."

    if [ ! -f "wp-config.php" ]; then
        wp config create \
            --dbname="$MYSQL_DATABASE" \
            --dbuser="$MYSQL_USER" \
            --dbpass="$MYSQL_PASSWORD" \
            --dbhost="mariadb:3306" \
            --allow-root
    fi

    echo "Waiting for database..."
    until wp db check --allow-root 2>/dev/null; do
        echo "Database not ready, waiting..."
        sleep 3
    done

    echo "Database is ready! Installing WordPress..."

    wp core install \
        --url="$SITE_URL" \
        --title="Inception Wordpress" \
        --admin_user="$ADMIN_USER" \
        --admin_password="$ADMIN_PASSWORD" \
        --admin_email="$ADMIN_EMAIL" \
        --skip-email \
        --allow-root

    wp user create "$WP_USER" "$WP_USER_EMAIL" \
        --role=author \
        --user_pass="$WP_USER_PASSWORD" \
        --allow-root
else
    echo "WordPress already installed. Skipping setup."
fi

echo "Starting PHP-FPM..."
exec php-fpm8.2 -F