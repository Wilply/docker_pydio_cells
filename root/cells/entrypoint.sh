#!/bin/sh

if [ $1 == "start" ];then
  if [ $PUID -lt 1000 ] || [ $PGID -lt 1000 ];then
    echo "[ERROR] UID or GID cannot be lighter than 1000, exiting"
    exit 1
  fi
  if [ ! -f "/home/abc/.config/pydio/cells/pydio.json" ]; then
    echo "[INFO] INITIALISING"
    addgroup -g ${PGID} abc
    adduser -h /home/abc -D -G abc -u ${PUID} abc
    echo "[INFO] INITIALISATION SUCESSFUL"
  fi
  chown -R abc:abc /cells && chmod -R 750 /cells
  chown abc:abc /home/abc/.config/ && chmod 750 /home/abc/.config/
  if [ ! -f "/home/abc/.config/pydio/cells/pydio.json" ]; then
    echo "INSTALLING AND STARTING PYDIO"
    if [ $SSL -eq 0 ];then
      su -c "cells install --no_ssl --bind $CELLS_BIND --external $CELLS_EXTERNAL" abc
    else
      su -c "cells install --bind $CELLS_BIND --external $CELLS_EXTERNAL" abc
    fi
  else
    echo "[INFO] STARTING PYDIO"
    su -c "cells start" abc
  fi
else
  echo $1
  echo "[ERROR], exiting"
  exit 1
fi
