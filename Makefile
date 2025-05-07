COMPOSE = docker compose -f srcs/docker-compose.yml --env-file srcs/.env

all: build up

build:
	@$(COMPOSE) build

up:
	@$(COMPOSE) up -d

down:
	@$(COMPOSE) down

clean:
	@$(COMPOSE) down --volumes

fclean: clean
	docker rmi mariadb_image wordpress_image nginx_image || true

re: fclean all

.PHONY: all build up down clean fclean re
