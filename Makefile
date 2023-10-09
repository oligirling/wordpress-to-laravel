.DEFAULT_GOAL := help
.PHONY: help
LOCAL_DOCKER_IMAGE=oligirling/wordpress-to-laravel
CONTAINER_NAME=wordpress-to-laravel
WORKING_DIR=/application
PORT=7005
DOCKER_COMMAND=docker run --rm -v ${PWD}:${WORKING_DIR} -w ${WORKING_DIR} --name ${CONTAINER_NAME} -p ${PORT}:${PORT} -it ${LOCAL_DOCKER_IMAGE}

build: ## Build docker image
	docker build -t ${LOCAL_DOCKER_IMAGE} . --no-cache

exec: ## Composer install
	${DOCKER_COMMAND} bash

install: ## Composer install
	${DOCKER_COMMAND} composer install

help:
	@grep -h -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'
