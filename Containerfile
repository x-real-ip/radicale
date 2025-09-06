FROM docker.io/tomsquest/docker-radicale:3.5.5.0

# Add radicale user with correct UID/GID
RUN echo "radicale:x:1000:2000:Radicale:/nonexistent:/sbin/nologin" >> /etc/passwd \
    && echo "radicale:x:2000:" >> /etc/group