FROM alpine:latest as builder
LABEL maintainer="Anton Egorov <anton@egorov.li>"

RUN apk --update --no-cache add \
  autoconf \
  automake \
  build-base \
  git \
  libtool \
  nasm

WORKDIR /src/mozjpeg
RUN git clone git://github.com/mozilla/mozjpeg.git ./

RUN autoreconf -fiv \
  && ./configure \
  && make install prefix=/usr/local libdir=/usr/local/lib64

FROM alpine:latest
COPY --from=builder /usr/local /usr/local
