#!/bin/sh

echo \#\#\# Cozy dockerized by Wilply \#\#\#

[ -z "${UID}" ] && UID=1500
[ -z "${GID}" ] && GID=1500
[ -z "${RUN_AS_ROOT}" ] && RUN_AS_ROOT=0
[ -z "${SSL}" ] && SSL=0
[ -z "${CELLS_BIND}" ] && CELLS_BIND=localhost:8080
[ -z "${CELLS_EXTERNAL}" ] && CELLS_EXTERNAL=pydio.example.com

if [ $(cat /etc/passwd | grep -c pydio) != 1 ] && [ ${RUN_AS_ROOT} -eq 0 ]; then
    echo "[INFO] Creating user & group pydio"

    addgroup -g ${GID} pydio
    adduser -h /cells -G pydio -D -H -u ${UID} pydio
    chown -R pydio:pydio /cells

fi

if [ ! -f "/cells/.config" ] && [ ${SSL} -eq 0 ]; then
    echo "[INFO] installing pydio without ssl"

    if [ ${RUN_AS_ROOT} -eq 1 ]; then
      cells install --no_ssl --bind ${CELLS_BIND} --external ${CELLS_EXTERNAL}
    else
      su pydio -c "cells install --no_ssl --bind ${CELLS_BIND} --external ${CELLS_EXTERNAL}"
    fi

elif [ ! -f "/cells/.config" ] && [ ${SSL} -ne 0 ]; then
    echo "[INFO] installing pydio with ssl"

    if [ ${RUN_AS_ROOT} -eq 1 ]; then
      cells install --bind ${CELLS_BIND} --external ${CELLS_EXTERNAL}
    else
      su pydio -c "cells install --bind ${CELLS_BIND} --external ${CELLS_EXTERNAL}"
    fi

fi

if [ ${RUN_AS_ROOT} -eq 1 ]; then

    su pydio -c "cells $*"

else
    echo "[WARNING] We recommend not to run pydio as root"

    cells $*

fi