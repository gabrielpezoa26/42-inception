COMPOSE_FILE = srcs/docker-compose.yml
DATA_PATH = /home/gcesar-n/data

all: up

build:
	docker compose -f $(COMPOSE_FILE) build

up: build dirs
	docker compose -f $(COMPOSE_FILE) up -d

stop:
	docker compose -f $(COMPOSE_FILE) stop

down:
	docker compose -f $(COMPOSE_FILE) down

clean:
	docker compose -f $(COMPOSE_FILE) down --rmi all -v

fclean: clean
	docker system prune -af
	sudo rm -rf $(DATA_PATH)/mariadb $(DATA_PATH)/wordpress

re: fclean all

start-docker:
	sudo systemctl start docker

dirs:
	mkdir -p $(DATA_PATH)/mariadb $(DATA_PATH)/wordpress

fix-db:
	docker compose -f $(COMPOSE_FILE) down
	-docker volume rm mariadb wordpress
	sudo rm -rf $(DATA_PATH)/mariadb $(DATA_PATH)/wordpress
	sudo mkdir -p $(DATA_PATH)/mariadb $(DATA_PATH)/wordpress
	docker compose -f $(COMPOSE_FILE) build --no-cache mariadb
	make up

check-data:
	ls -la /home/gcesar-n/data/mariadb
	ls -la /home/gcesar-n/data/wordpress