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
        make -j8

FROM ubuntu:noble
WORKDIR /tbamud
# Copy only the specific directories from the build stage
COPY --from=build /tbamud/bin ./bin
COPY --from=build /tbamud/log ./log
COPY --from=build /tbamud/lib ./lib
COPY --from=build /tbamud/autorun.sh ./
EXPOSE 4000
VOLUME /tbamud/lib
CMD [ "./autorun.sh" ]
