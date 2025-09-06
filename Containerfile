FROM docker.io/tomsquest/docker-radicale:3.5.5.0

# Force radicale user/group to 1000:2000
RUN groupmod -g 2000 radicale \
 && usermod -u 1000 -g 2000 radicale \
 && chown -R radicale:radicale /data /config

# Copy modified entrypoint to run as non-root
COPY /src/docker-entrypoint.sh /usr/local/bin

USER radicale
