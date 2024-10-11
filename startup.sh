#!/bin/bash

# Check if MySQL connection details are provided
if [ -z "$MYSQL_HOST" ]; then
  echo "Error: MYSQL_HOST environment variable is not set."
  exit 1
fi

# Check if MySQL user and database are provided
if [ -z "$MYSQL_USER" ] || [ -z "$MYSQL_DATABASE" ]; then
  echo "Error: MYSQL_USER and MYSQL_DATABASE environment variables must be set."
  exit 1
fi

# Proceed with the rest of your script to install FiveM
CONTAINER_ALREADY_STARTED="CONTAINER_ALREADY_STARTED_PLACEHOLDER"
if [ ! -e $CONTAINER_ALREADY_STARTED ]; then
  echo "***Downloading FiveM Server Version $fivem_version"
  wget -O- https://runtime.fivem.net/artifacts/fivem/build_proot_linux/master/$fivem_version/fx.tar.xz | tar -xJ -C /opt/fivem

  # Download and install txAdmin
  echo "***Downloading txAdmin Version $txadmin_version"
  wget https://github.com/tabarra/txAdmin/archive/refs/tags/v$txadmin_version.zip
  unzip v$txadmin_version.zip -d /opt/fivem/txAdmin
  rm v$txadmin_version.zip

  touch $CONTAINER_ALREADY_STARTED
fi

# Run the FiveM server with QBcore
echo "***Starting FiveM Server"
SCRIPT=$(readlink -f "$0")
SCRIPTPATH=$(dirname "$SCRIPT")

exec $SCRIPTPATH/alpine/opt/cfx-server/ld-musl-x86_64.so.1 \
--library-path "$SCRIPTPATH/alpine/usr/lib/v8/:$SCRIPTPATH/alpine/lib/:$SCRIPTPATH/alpine/usr/lib/" -- \
$SCRIPTPATH/alpine/opt/cfx-server/FXServer +set mysql_connection_string "mysql://${MYSQL_USER}:${MYSQL_PASSWORD}@${MYSQL_HOST}/${MYSQL_DATABASE}" +set citizen_dir $SCRIPTPATH/alpine/opt/cfx-server/citizen/ $*
exit