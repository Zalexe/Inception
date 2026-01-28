FROM debian:bullseye

RUN apt-get update && apt-get install -y \
	mariadb-server \
	&& rm -rf /var/lib/apt/lists/*

RUN mkdir -p /run/mysqld \
	&& chown -R mysql:mysql /run/mysqld

COPY tools/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 3306

USER mysql

ENTRYPOINT ["/entrypoint.sh"]
CMD ["mysqld"]
