# notebook-docker-base
Docker base image for HES-XPLAIN notebooks.

The image is built upon the [bitnami pytorch](https://hub.docker.com/r/bitnami/pytorch/) by VMware.

It includes Jupyter and all dependency packages necessary to run the provided notebooks.

## Release

To publish the package on the GitHub Packages registry, see [RELEASE](RELEASE.md).

## Cheatsheet

### build

```shell
docker build -t xplain-base .
```

### run
```shell
docker run --rm -it xplain-base
```

### run and launch jupyter
```shell
docker run --rm -p 8080:8080 -p 8888:8888 -it xplain-base
```

### run and override entry point
```shell
docker run --rm -it --entrypoint /bin/bash xplain-base
```

### authenticate

A [Personal Authentication Token](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/managing-your-personal-access-tokens)
with the `read repository` permission needs to be generated.

```shell
PAT=abcdef123456789
echo $PAT | docker login -u <username> ghcr.io --password-stdin
```

### tag and push image to registry

```shell
docker image tag xplain-base:latest ghcr.io/hes-xplain/xplain-base:latest
docker push ghcr.io/hes-xplain/xplain-base:latest
```

If `ghcr.io` is omitted, the registry used will be [Docker Hub](https://hub.docker.com/).
