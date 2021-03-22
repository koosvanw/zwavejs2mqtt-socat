# NOTE: deprecated
I'm leaving this up for future refence, but this image is unnecessary because Zwavejs2mqtt natively supports connecting to a remote serial device over tcp. Just enter `tcp://<host-ip>:<port>` in order to connect to your remote zwave stick over tcp.


# zwavejs2mqtt with socat for remote zwave stick
Created this docker image as I was already using a remote zwave stick in my setup with [Home-Assistant](https://www.home-assistant.io)

Instead of using a locally-connected zwave device, we can use a serial device mapped over the network with ser2net or socat and then map it to a local zwave serial device with socat.

Please [report issues on github](https://github.com/koosvanw/zwavejs2mqtt-socat/issues).

## Getting Started

This docker container ensures that:
 - socat is running
 - zwavejs2mqtt is running

If there are any failures, both socat and zwavejs2mqtt will be restarted.

### Prerequisites

See the normal zwavejs2mqtt docker container readme.

### Installing

The container needs some extra parameters as described below.

All [zwavejs-zwavejs2mqtt](https://hub.docker.com/r/zwavejs/zwavejs2mqtt/) image options are available and on top of that a few others have been added.

# Basic options

**DEBUG_VERBOSE**=0

Set to 1 to see more information
Default: 0

**PAUSE_BETWEEN_CHECKS**=2

In seconds, how much time to wait between checking running processes.
Default: 2

**LOG_TARGET**=/log.log

Path to log file. Omit to write logs to stdout.
Default: stdout

# Socat options

**SOCAT_ZWAVE_TYPE**="tcp"

**SOCAT_ZWAVE_HOST**="192.168.5.5"

**SOCAT_ZWAVE_PORT**="7676"

Where socat should connect to. Will be used as tcp://192.168.5.5:7676

**SOCAT_ZWAVE_LINK**="/dev/zwave"

What the zwave device should be mapped to. Use this in your zwavejs2mqtt configuration.

## Deployment

Example socat on host system:
```
/usr/bin/socat /dev/zwave,b115200,rawer,echo=0 tcp-listen:7677,reuseaddr,su=nobody
```

Or use ser2net service with for example this line in the ser2net.conf file:

```
7677:raw:0:/dev/serial/by-id/usb-0658_0200-if00:115200 8DATABITS NONE 1STOPBIT
```

## Acknowledgements
based on [mc303-zigbee2mqtt-socat](https://github.com/mc303/zigbee2mqtt-socat) image, [published on docker hub](https://hub.docker.com/r/mc303/zigbee2mqtt-socat)

Based on [zwavejs-zwavejs2mqtt](https://github.com/zwave-js/zwavejs2mqtt/) image, [published on docker hub](https://hub.docker.com/r/zwavejs/zwavejs2mqtt/).
