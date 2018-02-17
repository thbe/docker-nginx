FROM alpine
#
# BUILD:
#   wget https://raw.githubusercontent.com/thbe/docker-nginx/master/Dockerfile
#   docker build --rm --no-cache -t thbe/nginx .
#
# USAGE:
#   docker run --detach --restart always --cap-add=SYS_ADMIN -e "container=docker" \
#     --name nginx --hostname nginx.$(hostname -d) -p 80:80/tcp -p 443:443/tcp thbe/nginx
#   docker logs nginx
#   docker exec -ti nginx /bin/bash
#

# Set metadata
LABEL maintainer="Thomas Bendler <project@bendler-net.de>"
LABEL version="1.0"
LABEL description="Creates an Alpine container serving a NGINX instance"

# Set environment
ENV LANG en_US.UTF-8
ENV TERM xterm

# Set workdir (fix missing pid directory)
WORKDIR /run/nginx

# Install CUPS/AVAHI
RUN apk add --no-cache nginx

# Copy configuration files
COPY root /

# Expose NGINX standard http(s) ports
EXPOSE 80/tcp 443/tcp

# Start NGINX
CMD ["/usr/sbin/nginx", "-g", "daemon off;"]
