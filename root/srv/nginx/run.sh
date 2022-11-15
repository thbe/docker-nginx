#! /bin/sh
#
# Set root password and start NGINX instance
#
# Author:       Thomas Bendler <code@thbe.org>
# Date:         Tue Nov 15 22:12:56 CET 2022
#
# Release:      v1.0
#
# Prerequisite: This release needs a shell which could handle functions.
#               If shell is not able to handle functions, remove the
#               error section.
#
# ChangeLog:    v1.0 - Initial release
#

### Enable debug if debug flag is true ###
if [ -n "${NGINX_ENV_DEBUG}" ]; then
  set -ex
fi

### Error handling ###
error_handling() {
  if [ "${RETURN}" -eq 0 ]; then
    echo "${SCRIPT} successfull!"
  else
    echo "${SCRIPT} aborted, reason: ${REASON}"
  fi
  exit "${RETURN}"
}
trap "error_handling" EXIT HUP INT QUIT TERM
RETURN=0
REASON="Finished!"

### Default values ###
export PATH=/usr/sbin:/usr/bin:/sbin:/bin
export LC_ALL=C
export LANG=C
SCRIPT=$(basename ${0})

### Check prerequisite ###
if [ ! -f /.dockerenv ]; then RETURN=1; REASON="Not executed inside a Docker container, aborting!"; exit; fi

### Copy NGINX docker env variable to script ###
if [ -z ${NGINX_ENV_PASSWORD} ]; then
  NGINX_PASSWORD="nginx"
else
  NGINX_PASSWORD=${NGINX_ENV_PASSWORD}
fi

### Main logic to create an admin user for CUPS ###
if printf '%s' "${NGINX_PASSWORD}" | LC_ALL=C grep -q '[^ -~]\+'; then
  RETURN=1; REASON="CUPS password contain illegal non-ASCII characters, aborting!"; exit;
fi

### set password for root user ###
echo root:${NGINX_PASSWORD} | /usr/sbin/chpasswd
if [ ${?} -ne 0 ]; then RETURN=${?}; REASON="Failed to set password ${NGINX_PASSWORD} for user root, aborting!"; exit; fi

cat <<EOF

===========================================================

The dockerized NGINX instance is now ready for use! The web
interface is available here:

URL:       http://${NGINX_ENV_HOST}/
Username:  root
Password:  ${NGINX_PASSWORD}

===========================================================

EOF

### Start NGINX instance ###
/usr/sbin/nginx -g "daemon off;"
