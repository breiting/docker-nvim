all: build run

build:
	docker build --tag "nvim:latest" .

run:
	docker run --rm --tty --interactive \
		--user 1000:1000 \
		--volume "${PWD}/config:/home/docker/.config/nvim" \
		nvim:latest \
		nvim
