all: build

build:
	git submodule update
	docker build -t tbamud:latest .

start:
	@if [ "$$(docker inspect -f '{{.State.Running}}' tbamud 2>/dev/null)" != "true" ]; then \
		docker run -d --rm -v circlemud-data:/tbamud/lib --name tbamud -p 4000:4000 tbamud:latest; \
	fi

stop:
	@if [ "$$(docker inspect -f '{{.State.Running}}' tbamud 2>/dev/null)" = "true" ]; then \
		docker kill tbamud; \
	fi

clean:
	docker kill tbamud
	docker volume rm circlemud-data

play: start
	docker exec -it tbamud /tintin/tt++ -e "#ses tbaMud localhost 4000"
