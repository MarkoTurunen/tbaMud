# have to use 3.20, because 3.21 has issue with C compilers
FROM alpine:3.20 AS build 
RUN apk update \
    && apk --no-cache --update add build-base autoconf automake gcc

WORKDIR /tbamud
ADD tbamud .

RUN ./configure && \
        cd src && \
        touch .accepted && \
        make clean && \
        make -j8

FROM alpine:latest
WORKDIR /tbamud
# Copy only the specific directories from the build stage
COPY --from=build /tbamud/bin ./bin
COPY --from=build /tbamud/log ./log
COPY --from=build /tbamud/lib ./lib
COPY --from=build /tbamud/autorun.sh ./
EXPOSE 4000
VOLUME /tbamud/lib
CMD [ "./autorun.sh" ]
