NAME = inception

COMPOSE = docker compose -f srcs/docker-compose.yml

all:
	$(COMPOSE) up -d --build

down:
	$(COMPOSE) down

stop:
	$(COMPOSE) stop

start:
	$(COMPOSE) start

clean:
	$(COMPOSE) down -v
	docker system prune -af

re: clean all

.PHONY: all down stop start clean re
