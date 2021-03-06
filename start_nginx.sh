#! /bin/sh
#
# Start docker image that provides a NGINX instance
#
# Author:       Thomas Bendler <project@bendler-net.de>
# Date:         Sat Feb 17 19:12:17 CET 2018
#
# Release:      v1.0
#
# ChangeLog:    v1.0 - Initial release
#

### Set standard password if not set with local environment variable ###
if [ -n "${NGINX_PASSWORD}" ]; then
  NGINX_PASSWORD=password
fi

### Run docker instance ###
docker run --detach --restart always \
  --cap-add=SYS_ADMIN -e "container=docker" \
  -e NGINX_ENV_HOST="$(hostname -f)" \
  -e NGINX_ENV_PASSWORD="${NGINX_PASSWORD}" \
  -e NGINX_ENV_DEBUG="${NGINX_DEBUG}" \
  --name nginx --hostname nginx.$(hostname -f | sed -e 's/^[^.]*\.//') \
  -p 80:80/tcp -p 443:443/tcp \
  thbe/nginx
