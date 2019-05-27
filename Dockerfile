FROM alpine:latest as builder
LABEL maintainer="Anton Egorov <anton@egorov.li>"

ARG tag=v3.3.1

RUN apk --update --no-cache add \
    build-base \
    autoconf \
    automake \
    libtool \
    pkgconf \
    nasm \
    tar

WORKDIR /src/mozjpeg
ADD https://github.com/mozilla/mozjpeg/archive/$tag.tar.gz ./

RUN tar -xzf $tag.tar.gz
RUN rm $tag.tar.gz

RUN SRC_DIR=$(ls -t1 -d mozjpeg-* | head -n1) && \
    cd $SRC_DIR && \
    autoreconf -fiv && \
    cd .. && \
    sh $SRC_DIR/configure && \
    make install \
         prefix=/usr/local \
         libdir=/usr/local/lib64

FROM alpine:latest
LABEL maintainer="Anton Egorov <anton@egorov.li>"

COPY --from=builder /usr/local /usr/local
