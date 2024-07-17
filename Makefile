COMPOSE := ./srcs/docker-compose.yml

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

start: build up

restart: down start

.PHONY: up down build logs clean start restart