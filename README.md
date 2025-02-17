# tbaMUD
tba MUD Docker Image

## Building
```bash
docker build -t tbamud:latest .
```

## Running
```bash
docker run -d --rm -v circlemud-data:/tbamud/lib --name tbamud -p 4000:4000 tbamud:latest
```

## Accessing tba MUD
```bash
telnet localhost 4000
```
