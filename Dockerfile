FROM alpine:latest as builder
LABEL maintainer="Anton Egorov <anton@egorov.li>"

RUN apk --update --no-cache add \
  build-base \
  cmake \
  git \
  nasm

WORKDIR /src/mozjpeg
RUN git clone git://github.com/mozilla/mozjpeg.git ./

RUN cmake -G"Unix Makefiles" -DCMAKE_INSTALL_PREFIX=/usr/local -DCMAKE_INSTALL_LIBDIR=/usr/local/lib64 .. \
  && make install prefix=/usr/local libdir=/usr/local/lib64

FROM alpine:latest
LABEL maintainer="Anton Egorov <anton@egorov.li>"
COPY --from=builder /usr/local /usr/local
