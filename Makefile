COMPOSE := ./srcs/docker-compose.yml

pull:
	docker-compose -f $(COMPOSE) pull

up:
	docker-compose -f $(COMPOSE) up -d

down:
	docker-compose -f $(COMPOSE) down

build:
	docker-compose -f $(COMPOSE) build

logs:
	docker-compose -f $(COMPOSE) logs -f

clean:
	docker-compose -f $(COMPOSE) down -v --rmi all --remove-orphans

setup: pull build

start: setup up

restart: down start

.PHONY: up down build logs clean pull setup start restart