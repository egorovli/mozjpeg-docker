FROM alpine:latest
LABEL maintainer="Anton Egorov <anton@egorov.li>"

RUN apk --update add \
  autoconf \
  automake \
  build-base \
  git \
  libtool \
  nasm \
  && rm -rf /var/cache/apk/*

WORKDIR /source
RUN git clone git://github.com/mozilla/mozjpeg.git ./

RUN autoreconf -fiv \
  && ./configure \
  && make install prefix=/usr/local libdir=/usr/local/lib64 \
  && apk del \
    autoconf \
    automake \
    build-base \
    git \
    libtool \
    nasm \
  && rm -rf /var/cache/apk/*