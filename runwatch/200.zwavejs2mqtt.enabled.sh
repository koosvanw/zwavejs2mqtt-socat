#!/usr/bin/env bash

BINARY="node"
PARAMS="bin/www"

######################################################

CMD=$1

if [[ -z "${CONFIG_LOG_TARGET}" ]]; then
  LOG_FILE="/dev/null"
else
  LOG_FILE="${CONFIG_LOG_TARGET}"
fi

case $CMD in

describe)
    echo "Sleep"
    ;;

## exit 0 = is not running
## exit 1 = is running
is-running)
    if pgrep -f "$BINARY $PARAMS" >/dev/null 2>&1 ; then
        exit 1
    fi
    exit 0
    ;;

start)
    echo "Starting... $BINARY" >> "$LOG_FILE"
    if pgrep -f "socat" >/dev/null 2>&1 ; then
        # socat is running
        cd /usr/src/app
        $BINARY $PARAMS 2>$LOG_FILE >$LOG_FILE &
        sleep 15
        exit 0
    else
        # socat is not running
        echo "##### Socat is not running, skipping start of zwavejs2mqtt"
        exit 1
    fi
    ;;

start-fail)
    echo "Start failed! $BINARY $PARAMS"
    ;;

stop)
    echo "Stopping... $BINARY $PARAMS"
    cd /usr/src/app
    kill -9 $(pgrep -f "$BINARY")
    ;;

esac
