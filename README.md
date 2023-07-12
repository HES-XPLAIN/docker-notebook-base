# notebooks-docker
Docker images for XAI notebooks

The base image is built upon the [bitnami](https://bitnami.com/) [pytorch image](https://hub.docker.com/r/bitnami/pytorch/) image by VMware.

## build

```shell
docker build -t xplain-base .
```

## run
```shell
docker run -it xplain-base
```

## run and override entry point
```shell
docker run -it --entrypoint /bin/bash xplain-base
```
