FROM ubuntu:noble AS build
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
        autoconf \
        automake \
        build-essential

WORKDIR /tbamud
ADD tbamud .

RUN ./configure && \
        cd src && \
        touch .accepted && \
        make clean && \
        make

FROM ubuntu:noble
WORKDIR /tbamud
COPY --from=build /tbamud .
EXPOSE 4000
VOLUME /tbamud/lib
CMD [ "./autorun.sh" ]
