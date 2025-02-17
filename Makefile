all: build

build:
	docker build -t tbamud:latest .

start:
	docker run -d --rm -v circlemud-data:/tbamud/lib --name tbamud -p 4000:4000 tbamud:latest

stop:
	docker kill tbamud

clean:
	docker kill tbamud
	docker volume rm circlemud-data
