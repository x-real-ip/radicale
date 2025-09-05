FROM docker.io/tomsquest/docker-radicale

# Force radicale user/group to 1000:2000
RUN groupmod -g 2000 radicale \
 && usermod -u 1000 -g 2000 radicale \
 && chown -R radicale:radicale /data /config
