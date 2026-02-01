NAME = inception

COMPOSE = docker compose -f srcs/docker-compose.yml --project-name $(NAME)

all: build up

build:
	mkdir -p /home/cmarrued/data/wordpress
	mkdir -p /home/cmarrued/data/mariadb
	$(COMPOSE) build --no-cache

up:
	$(COMPOSE) up

down:
	$(COMPOSE) down

downv:
	$(COMPOSE) down -v

stop:
	$(COMPOSE) stop

kill: 
	$(COMPOSE) kill

start:
	$(COMPOSE) start

logs:
	$(COMPOSE) logs -f

ps:
	$(COMPOSE) ps

status: 
	@docker ps

clean: down

fclean: clean downv

re: clean build up

sprune: downv
	@echo "This action will remove all Docker containers, images, volumes, and networks"
	@read -p "Are you sure you want to continue? (y/N) " confirm; \
	if [ "$$confirm" != "y" ]; then \
		echo "Aborted."; \
		exit 1; \
	fi
	docker system prune -a --volumes -f
	sudo rm -rf /home/cmarrued/data/wordpress
	sudo rm -rf /home/cmarrued/data/mariadb

prune

.PHONY: all down stop start restart logs status clean fclean re prune
