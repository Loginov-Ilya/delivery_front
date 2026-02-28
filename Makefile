# Makefile для React + Docker
IMAGE_NAME = delivery_front_react
CONTAINER_NAME = delivery_front_react
HOST_PORT = 8080
CONTAINER_PORT = 80

.PHONY: build run stop clean restart logs run-interactive rebuild ps

build:
	docker build -t $(IMAGE_NAME) .

run:
	docker run -d -p $(HOST_PORT):$(CONTAINER_PORT) --name $(CONTAINER_NAME) $(IMAGE_NAME)

stop:
	docker stop $(CONTAINER_NAME) || true

clean: stop
	docker rm $(CONTAINER_NAME) || true
	docker rmi $(IMAGE_NAME) || true

restart: stop build run

logs:
	docker logs $(CONTAINER_NAME)

run-interactive:
	docker run -it --rm -p $(HOST_PORT):$(CONTAINER_PORT) --name $(CONTAINER_NAME) $(IMAGE_NAME)

rebuild: build run

ps:
	docker ps -f name=$(CONTAINER_NAME)