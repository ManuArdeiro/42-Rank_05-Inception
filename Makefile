LOGIN   = $(shell grep 'LOGIN=' secrets/credentials.txt | cut -d'=' -f2 | xargs)

COMPOSE	= docker compose -f srcs/docker-compose.yml --env-file srcs/.env

VOLUMES = "/home/$(LOGIN)/data"

# CONSTRUCCION__________________________________________________________________

all: build up

build:
		@$(COMPOSE) build

up:
		sudo mkdir -p "$(VOLUMES)/wordpress" "$(VOLUMES)/mariadb"
		$(COMPOSE) up -d

down:
		$(COMPOSE) down

start:
		$(COMPOSE) start

stop:
		$(COMPOSE) stop

shell:
		read -p "=> Enter service: " service; \
		$(COMPOSE) exec -it $$service /bin/bash

# LIMPIEZA______________________________________________________________________

clean:
		$(COMPOSE) down

fclean: clean
		@docker rmi mariadb_image wordpress_image nginx_image || true
		@sudo rm -rf "$(VOLUMES)"

re: fclean all

.PHONY: all build up down start stop shell clean fclean re

