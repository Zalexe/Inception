FROM debian:11.11

RUN apt-get update && apt-get install -y \
	nginx \
	openssl \
	&& rm -rf /var/lib/apt/lists/*

WORKDIR /app

RUN openssl genrsa -out server.key 2048 \
    && openssl req -new -x509 -key server.key -out server.crt -days 365 -subj "/CN=localhost" \
	&& chmod 644 server.crt \
    && chmod 600 server.key

COPY conf/nginx.conf /etc/nginx/

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]
