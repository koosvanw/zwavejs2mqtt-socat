FROM zwavejs/zwavejs2mqtt:latest

# Install socat
RUN apk add --no-cache --virtual musl-utils tini socat bash

RUN mkdir /runwatch
COPY runwatch/run.sh /runwatch/run.sh
# Monitor socat
COPY runwatch/100.socat-zwave.enabled.sh /runwatch/100.socat-zwave.enabled.sh
# Monitor Zwavejs2mqtt
COPY runwatch/200.zwavejs2mqtt.enabled.sh /runwatch/200.zwavejs2mqtt.enabled.sh
RUN chmod 777 /runwatch/*.sh

ENTRYPOINT [ "/sbin/tini", "--", "/runwatch/run.sh" ]
