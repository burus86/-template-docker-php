# variables
.DEFAULT_GOAL := help
.PHONY : help docker-start docker-stop docker-ps docker-logs docker-bash
CONTAINER_NAME = skeleton-docker-php
CONTAINER_OPTIONS = -it
RUN = docker exec $(CONTAINER_OPTIONS) $(CONTAINER_NAME)
DOCKER_COMPOSE_FILE = docker/docker-compose.yml
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

## Build and up all docker containers defined in docker/docker-compose.yml
docker-start:
	@printf "${COLOR_COMMENT}Building and starting all docker containers defined in ${DOCKER_COMPOSE_FILE} ${COLOR_RESET}\n"
	@echo "---------------------------"
	@echo
	docker-compose -f ${DOCKER_COMPOSE_FILE} up -d --build --remove-orphans
	@echo

## Stop all docker containers defined in docker/docker-compose.yml
docker-stop:
	@printf "${COLOR_COMMENT}Stopping all docker containers defined in ${DOCKER_COMPOSE_FILE} ${COLOR_RESET}\n"
	@echo "---------------------------"
	@echo
	docker-compose -f ${DOCKER_COMPOSE_FILE} down
	@echo

## List of all docker containers created. Example: make docker-ps or make docker-ps OPTIONS=-as
docker-ps:
	@printf "${COLOR_COMMENT}List of all docker containers created ${COLOR_RESET}\n"
	@echo "---------------------------"
	@echo
	docker ps $(OPTIONS)
	@echo

## Show logs for PHP docker container
docker-logs:
	@printf "${COLOR_COMMENT}PHP docker container logs ${COLOR_RESET}\n"
	@echo "---------------------------"
	@echo
	docker logs -f -n20 $(CONTAINER_NAME)

## Access bash for PHP docker container
docker-bash:
	@printf "${COLOR_COMMENT}PHP docker container bash ${COLOR_RESET}\n"
	@echo "---------------------------"
	@echo
	$(RUN) bash
