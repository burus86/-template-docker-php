# variables
.DEFAULT_GOAL := help
.PHONY : help start stop bash logs
CONTAINER_NAME = skeleton-docker-php
CONTAINER_OPTIONS = -it
RUN = docker exec $(CONTAINER_OPTIONS) $(CONTAINER_NAME)
COLOR_RESET = \033[0m
COLOR_INFO = \033[32m
COLOR_COMMENT = \033[33m


## Help
help:
	@printf "${COLOR_COMMENT}Usage:${COLOR_RESET}\n"
	@printf " make [target]\n\n"
	@printf "${COLOR_COMMENT}Available targets:${COLOR_RESET}\n"
	@awk '/^[a-zA-Z\-\_0-9\.@]+:/ { \
		helpMessage = match(lastLine, /^## (.*)/); \
		if (helpMessage) { \
			helpCommand = substr($$1, 0, index($$1, ":")); \
			helpMessage = substr(lastLine, RSTART + 3, RLENGTH); \
			printf " ${COLOR_INFO}%-16s${COLOR_RESET} %s\n", helpCommand, helpMessage; \
		} \
	} \
	{ lastLine = $$0 }' $(MAKEFILE_LIST)

## Start docker containers
start:
	@printf "${COLOR_COMMENT}Starting docker containers ${COLOR_RESET}\n"
	@echo "---------------------------"
	@echo
	docker-compose -f docker/docker-compose.yml up -d --build --remove-orphans
	@echo

## Stop docker containers
stop:
	@printf "${COLOR_COMMENT}Stopping docker containers ${COLOR_RESET}\n"
	@echo "---------------------------"
	@echo
	docker-compose -f docker/docker-compose.yml down --remove-orphans
	@echo

## Access docker container bash
bash:
	@printf "${COLOR_COMMENT}Access docker container bash ${COLOR_RESET}\n"
	@echo "---------------------------"
	@echo
	$(RUN) bash

## Show docker container logs
logs:
	@printf "${COLOR_COMMENT}Show docker container logs ${COLOR_RESET}\n"
	@echo "---------------------------"
	@echo
	docker logs -f -n20 $(CONTAINER_NAME)
