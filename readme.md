# mozjpeg-docker

`mozjpeg-docker` is a [Docker](https://www.docker.com) image based on the latest [Alpine linux](https://alpinelinux.org) to provide binaries of the [mozilla/mozjpeg](https://github.com/mozilla/mozjpeg) to other Docker images.

## Custom mozilla/mozjpeg version

By default, the latest version of [mozilla/mozjpeg](https://github.com/mozilla/mozjpeg) source code is used. You can also build a different version:

```bash
docker build -t mozjpeg-docker --build-arg tag=v3.0 .
```
