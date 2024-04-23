# notebook-docker-base
Docker base image for HES-XPLAIN notebooks.

The image is built upon the [bitnami pytorch](https://hub.docker.com/r/bitnami/pytorch/) by VMware.

It includes Jupyter and all dependency packages necessary to run the provided notebooks.

## Build

### authenticate (build from hub.docker.com)

Sign in to [Docker Hub](https://hub.docker.com/) and create an [access-token](docs.docker.com/go/access-tokens),
then authenticate:

```shell
PAT=<token>
echo $PAT | docker login -u <usernam> --password-stdin
```

This is necessary to pull the bitnami pytorch image that is hosted on the Docker Hub registry.

### build

Build the image using the image:

```shell
docker buildx build -t xplain-base .
```

## Run

### simple run
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

## Run with CUDA support

* Refer to [nVidia Container Toolkit](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/) to set up the container runtime on the host machine.

### run with cuda support and launch jupyter

```shell
sudo docker run --rm -p 8080:8080 -p 8888:8888 --runtime=nvidia --gpus all xplain-base
```

### run with cuda support and override entry point
```shell
sudo docker run --rm -p 8080:8080 -p 8888:8888 -it --runtime=nvidia --gpus all --entrypoint /bin/bash xplain-base
```

## Release (manual)

To publish the package on the GitHub Packages registry, see [RELEASE](RELEASE.md).

### authenticate (push to ghcr.io)

A [Personal Authentication Token](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/managing-your-personal-access-tokens)
with the `read repository` permission needs to be generated.

```shell
GHCRPAT=abcdef123456789
echo $GHCRPAT | docker login -u <username> ghcr.io --password-stdin
```

### tag and push image to registry

```shell
docker image tag xplain-base:latest ghcr.io/hes-xplain/xplain-base:latest
docker push ghcr.io/hes-xplain/xplain-base:latest
```

If `ghcr.io` is omitted, the registry used will be [Docker Hub](https://hub.docker.com/).

## Release

To publish the package on the GitHub Packages registry, see [RELEASE](RELEASE.md).
