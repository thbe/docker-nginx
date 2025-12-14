# syntax=docker/dockerfile:1
FROM alpine:3.21
#
# BUILD:
#   docker build --rm --no-cache -t thbe/nginx .
#
# USAGE:
#   docker run --detach --restart always \
#     --name nginx --hostname nginx.$(hostname -d) -p 80:80/tcp -p 443:443/tcp thbe/nginx
#   docker logs nginx
#   docker exec -ti nginx /bin/sh
#

# Set metadata
LABEL maintainer="Thomas Bendler <code@thbe.org>"
LABEL version="1.3"
LABEL description="Creates an Alpine container serving a NGINX instance"

# Set environment
ENV LANG=en_US.UTF-8
ENV TERM=xterm

# Install nginx and set up directories in a single layer
RUN apk add --no-cache nginx \
    && mkdir -p /run/nginx \
    && chown -R nginx:nginx /run/nginx /srv

# Copy configuration files
COPY --chown=nginx:nginx root /

# Make startup script executable
RUN chmod 755 /srv/nginx/run.sh

# Set workdir
WORKDIR /run/nginx

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
    CMD wget --quiet --tries=1 --spider http://localhost:80/ || exit 1

# Expose NGINX standard http(s) ports
EXPOSE 80/tcp 443/tcp

# Start NGINX
CMD ["/srv/nginx/run.sh"]
