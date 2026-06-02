COMPOSE_FILE = srcs/docker-compose.yml
DATA_PATH = /home/gabriel/data

all: up

build:
	docker-compose -f $(COMPOSE_FILE) build

up: build
	docker-compose -f $(COMPOSE_FILE) up -d

stop:
	docker-compose -f $(COMPOSE_FILE) stop

down:
	docker-compose -f $(COMPOSE_FILE) down

logs:
	docker-compose -f $(COMPOSE_FILE) logs -f

clean:
	docker-compose -f $(COMPOSE_FILE) down --rmi all -v

fclean: clean
	docker system prune -af
	sudo rm -rf $(DATA_PATH)/mariadb/* $(DATA_PATH)/wordpress/*

re: fclean all

mariadb:
	docker-compose -f $(COMPOSE_FILE) up -d --build mariadb

.PHONY: all build up down logs clean fclean re mariadb