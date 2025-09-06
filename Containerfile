FROM docker.io/tomsquest/docker-radicale:3.5.5.0

ARG BUILD_UID=1000
ARG BUILD_GID=2000

RUN sed -i "s/^radicale:x:[0-9]*:[0-9]*/radicale:x:${BUILD_UID}:${BUILD_GID}/" /etc/passwd \
    && sed -i "s/^radicale:x:[0-9]*/radicale:x:${BUILD_GID}/" /etc/group \
    && chown -R ${BUILD_UID}:${BUILD_GID} /data /config
