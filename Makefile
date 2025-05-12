COMPOSE = docker compose -f srcs/docker-compose.yml --env-file srcs/.env
VOLUMES = "/home/$(shell grep 'LOGIN=' secrets/credentials.txt | cut -d'=' -f2)/data"

# CONSTRUCCION__________________________________________________________________
all: build up

build:
	@$(COMPOSE) build

up:
	@mkdir -p "$(VOLUMES)/mariadb" "$(VOLUMES)/wordpress"
	@sudo chown -R 1001:1001 "$(VOLUMES)/mariadb"  # MySQL usa UID 1001
	@sudo chown -R 33:33 "$(VOLUMES)/wordpress"    # WordPress usa UID 33
	@$(COMPOSE) up -d

down:
	@$(COMPOSE) down

start:
	@$(COMPOSE) start

stop:
	@$(COMPOSE) stop

shell:
	@bash -c '\
		read -p "=> Enter service [mariadb|wordpress|nginx]: " service; \
		$(COMPOSE) exec -it $$service /bin/bash || $(COMPOSE) exec -it $$service /bin/sh'

# LIMPIEZA______________________________________________________________________
clean: down

fclean: clean
	@$(COMPOSE) down --volumes --rmi all --remove-orphans 2>/dev/null || true
	@docker network inspect inception_network >/dev/null 2>&1 && \
	docker network rm inception_network || true
	@docker volume prune -f 2>/dev/null || true
	@sudo rm -rf "$(VOLUMES)"

# REBUILD_______________________________________________________________________
quick-re: clean
	@$(COMPOSE) up -d --force-recreate

re: fclean all

.PHONY: all build up down start stop shell clean fclean re quick-re