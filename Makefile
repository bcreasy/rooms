IMAGE=genetik/rooms
NAME=rooms

.PHONY: all build run start stop shell log clean

all: build

build: clean
	docker build -t $(IMAGE) --rm=true --label=$(NAME) .

run: build
	docker run \
		-u rooms \
		--name "rooms" \
		-p 1337:1337 \
		-d $(IMAGE)

start:
	@ID=$$(docker ps -q -a -f "name=$(NAME)") && \
		if test "$$ID" != ""; then docker start $$ID; fi

stop:
	@ID=$$(docker ps -q -a -f "name=$(NAME)") && \
		if test "$$ID" != ""; then docker stop $$ID; fi

shell:
	docker exec -it $(NAME) /bin/bash

log:
	docker logs --follow $(NAME)

clean:
	@ID=$$(docker ps -q -a -f "name=$(NAME)") && \
		if test "$$ID" != ""; then docker rm -f $$ID; fi
	@ID=$$(docker images -q -f "label=$(NAME)") && \
		if test "$$ID" != ""; then docker rmi -f $$ID; fi
