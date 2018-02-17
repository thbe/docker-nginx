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

### Run docker instance ###
docker run --detach --restart always \
  --cap-add=SYS_ADMIN -e "container=docker" \
  --name nginx --hostname nginx.$(hostname -f | sed -e 's/^[^.]*\.//') \
  -p 80:80/tcp -p 443:443/tcp \
  thbe/nginx
