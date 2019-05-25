FROM alpine:latest as builder
LABEL maintainer="Anton Egorov <anton@egorov.li>"

ARG tag=master

RUN apk --update --no-cache add \
    build-base \
    cmake \
    git \
    nasm

WORKDIR /src/mozjpeg

RUN git clone git://github.com/mozilla/mozjpeg.git ./
RUN if [[ $tag != "master" ]]; \
    then git checkout $tag; \
    fi

RUN cmake -G "Unix Makefiles" \
          -D CMAKE_INSTALL_PREFIX=/usr/local \
          -D CMAKE_INSTALL_LIBDIR=/usr/local/lib64 \
          -D PNG_SUPPORTED=0 \
          . && \
    make install \
         prefix=/usr/local \
         libdir=/usr/local/lib64

FROM alpine:latest
LABEL maintainer="Anton Egorov <anton@egorov.li>"

COPY --from=builder /usr/local /usr/local
