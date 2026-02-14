#!/bin/sh
set -e

if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "Initializing MariaDB database..."
    mariadb-install-db --user=mysql --datadir=/var/lib/mysql
fi

echo "Starting MariaDB..."
mysqld --user=mysql --datadir=/var/lib/mysql &

echo "Waiting for MariaDB to be ready..."
until mariadb -e "SELECT 1;" >/dev/null 2>&1; do
    sleep 1
done

echo "MariaDB ready, configuring database..."

mariadb << EOF
CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;
CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_USER}'@'%';
FLUSH PRIVILEGES;
EOF

echo "Database configured. Restarting MariaDB as main process..."

mysqladmin shutdown

exec mysqld --user=mysql --datadir=/var/lib/mysql