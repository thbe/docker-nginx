# nginx on Docker

[![Build Status](https://img.shields.io/docker/automated/thbe/nginx.svg)](https://hub.docker.com/r/thbe/nginx/builds/) [![GitHub Stars](https://img.shields.io/github/stars/thbe/docker-nginx.svg)](https://github.com/thbe/docker-nginx/stargazers) [![Docker Stars](https://img.shields.io/docker/stars/thbe/nginx.svg)](https://hub.docker.com/r/thbe/nginx) [![Docker Pulls](https://img.shields.io/docker/pulls/thbe/nginx.svg)](https://hub.docker.com/r/thbe/nginx)

This is a Docker image to run a NGINX instance.

This Docker image is based on the offical [Alpine](https://hub.docker.com/r/_/alpine/) image.

#### Table of Contents

- [Install Docker](https://github.com/thbe/docker-nginx#install-docker)
- [Download](https://github.com/thbe/docker-nginx#download)
- [How to use this image](https://github.com/thbe/docker-nginx#how-to-use-this-image)
- [Next steps](https://github.com/thbe/docker-nginx#next-steps)
- [Important notes](https://github.com/thbe/docker-nginx#important-notes)
- [Update Docker image](https://github.com/thbe/docker-nginx#update-docker-image)
- [Advanced usage](https://github.com/thbe/docker-nginx#advanced-usage)
- [Technical details](https://github.com/thbe/docker-nginx#technical-details)
- [Development](https://github.com/thbe/docker-nginx#development)

## Install Docker

To use this image you have to [install Docker](https://docs.docker.com/engine/installation/) first.

## Download

You can get the trusted build from the [Docker Hub registry](https://hub.docker.com/r/thbe/nginx/):

```
docker pull thbe/nginx
```

Alternatively, you may build the Docker image from the
[source code](https://github.com/thbe/docker-nginx#build-from-source-code) on GitHub.

## How to use this image

### Environment variables

You can use two environment variables that will be recognized by the start script.

#### `NGINX_PASSWORD`

If this environment variable is set, the string will be used as the password for the `root` user.

#### `NGINX_DEBUG`

If this environment variable is set, the scripts inside the container will run in debug mode.

### Start the NGINX instance

The instance can be started by the [start script](https://raw.githubusercontent.com/thbe/docker-nginx/master/start_nginx.sh)
from GitHub:

```
wget https://raw.githubusercontent.com/thbe/docker-nginx/master/start_nginx.sh
export NGINX_PASSWORD='SeCre!1'
chmod 755 start_nginx.sh
./start_nginx.sh
```

### Check server status

You can use the standard Docker commands to examine the status of the NGINX instance:

```
docker logs --tail 1000 --follow --timestamps nginx
```

## Next steps

The next release of this Docker image should have a persistent NGINX configuration.

## Important notes

The username for the web server is `root`/`password` unless you don't change the password with the environment
variable as described in the [Environment variables](https://github.com/thbe/docker-nginx#how-to-use-this-image)
section.

## Update Docker image

Simply download the trusted build from the [Docker Hub registry](https://hub.docker.com/r/thbe/nginx/):

```
docker pull thbe/nginx
```

## Advanced usage

### Build from source code

You can build the image also from source. To do this you have to clone the
[docker-nginx](https://github.com/thbe/docker-nginx) repository from GitHub:

```
git clone https://github.com/thbe/docker-nginx.git
cd docker-nginx
docker build --rm --no-cache -t thbe/nginx .
```

### Bash shell inside container

If you need a shell inside the container you can run the following command:

```
docker exec -ti nginx /bin/sh
```

## Technical details

- Alpine base image
- nginx binary from official Alpine package repository

## Development

If you like to add functions or improve this Docker image, feel free to fork the repository and send me a merge request with the modification.
