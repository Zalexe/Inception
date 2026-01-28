FROM debian:bullseye

RUN apt-get update && apt-get install -y \
	nginx \
	openssl \
	&& rm -rf /var/lib/apt/lists/*

COPY conf/nginx.conf /etc/nginx/nginx.conf
COPY tools/ssl.sh /ssl.sh

RUN chmod +x /ssl.sh

EXPOSE 443

ENTRYPOINT ["/ssl.sh"]
CMD ["nginx", "-g", "daemon off;"]
