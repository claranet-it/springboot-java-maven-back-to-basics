.PHONY: up down logs status start-server help
.DEFAULT_GOAL := help
run-docker-compose = docker compose -f docker-compose.yml
run-maven = ./mvnw

up: # Start containers and tail logs
	$(run-docker-compose) up -d

down: # Stop all containers
	$(run-docker-compose) down --remove-orphans

logs: # Tail container logs
	$(run-docker-compose) logs -f mariadb

status: # Show status of all containers
	$(run-docker-compose) ps

start-server: # Start server
	$(run-maven) spring-boot:run

help: # make help
	@awk 'BEGIN {FS = ":.*#"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n"} /^[a-zA-Z0-9_-]+:.*?#/ { printf "  \033[36m%-27s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)
