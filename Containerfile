FROM docker.io/tomsquest/docker-radicale

ARG BUILD_UID=1000
ARG BUILD_GID=1000

# Change the existing radicale user/group
RUN groupmod -g ${BUILD_GID} radicale \
 && usermod -u ${BUILD_UID} -g ${BUILD_GID} radicale \
 && chown -R radicale:radicale /data /config
