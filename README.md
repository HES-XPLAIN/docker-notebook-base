# notebooks-docker
Docker images for XAI notebooks

The base image is built upon the [bitnami pytorch](https://hub.docker.com/r/bitnami/pytorch/) by VMware.

## Release

To publish the package on the GitHub Packages registry, see [RELEASE.md].

## Cheatsheet

### build

```shell
docker build -t xplain-base .
```

### run
```shell
docker run -it xplain-base
```

### run and launch jupyter
```shell
docker run -p 8080:8080 -p 8888:8888 -it xplain-base
```

### run and override entry point
```shell
docker run -it --entrypoint /bin/bash xplain-base
```

### tag and push image to registry
```shell
docker image tag xplain-base:latest registry-host:5000/hes-xplain/xplain-base:latest
docker push registry-host:5000/hes-xplain/xplain-base:latest
```

If `registry-host:5000/` is omitted, the registry used will be [Docker Hub](https://hub.docker.com/).
