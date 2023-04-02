USER_NAME ?= timur8298 # логин в докерхаб

all: help

help:
	@echo " list для отображения списка всех образов"
	@echo " build-<name> для билда <name> образа (например 'make build-post' для билда образа post)"
	@echo " build для билда всех образов"
	@echo " push-<name> для публикации в докер хаб <name> образа (например 'make push-ui' для публикации образа ui)"
	@echo " push для публикации в докер хаб всех образов"
	@echo " start запускает контейнеры локально"
	@echo " stop останавливает контейнеры"

list:
	@echo ui
	@echo comment
	@echo post
	@echo prometheus

build: build-ui build-comment build-post build-prometheus

build-ui:
	@docker build -f src/ui/Dockerfile -t ${USER_NAME}/ui src/ui

build-comment:
	@docker build -f src/comment/Dockerfile -t ${USER_NAME}/comment src/comment

build-post:
	@docker build -f src/post-py/Dockerfile -t ${USER_NAME}/post src/post-py

build-prometheus:
	@docker build -f monitoring/prometheus/Dockerfile -t ${USER_NAME}/prometheus monitoring/prometheus

push: push-ui push-comment push-post push-prometheus

push-ui:
	docker push ${USER_NAME}/ui

push-post:
	docker push ${USER_NAME}/post

push-comment:
	docker push ${USER_NAME}/comment

push-prometheus:
	docker push ${USER_NAME}/prometheus

start:
	@docker-compose -f ./docker/docker-compose.yml up -d

stop:
	@docker-compose -f ./docker/docker-compose.yml down
