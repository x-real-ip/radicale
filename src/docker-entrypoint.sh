#!/bin/sh

set -e

# If running as root, keep old UID/GID logic from original image
    # Change uid/gid of radicale if vars specified
    if [ -n "$UID" ] || [ -n "$GID" ]; then
        if [ ! "$UID" = "$(id radicale -u)" ] || [ ! "$GID" = "$(id radicale -g)" ]; then
            if grep -e "\s/\s.*\sro[\s,]" /proc/mounts > /dev/null; then
                echo "You specified custom UID/GID (UID: $UID, GID: $GID)."
                echo "UID/GID can only be changed when not running the container with --read-only."
                exit 1
            fi
            if [ -n "$UID" ]; then
                usermod -o -u "$UID" radicale
            fi
            if [ -n "$GID" ]; then
                groupmod -o -g "$GID" radicale
            fi
        fi
    fi

    # If requested and running as root, mutate the ownership of bind-mounts
    if [ "$TAKE_FILE_OWNERSHIP" = "true" ]; then
        chown -R radicale:radicale /data
    fi

    # Run radicale as the "radicale" user
    if [ "$1" = "/venv/bin/radicale" ]; then
        exec su-exec radicale "$@"
    else
        exec "$@"
    fi
else
    # Added by x-real-ip to allow running as non-root user
    if ! id -un "$(id -u)" >/dev/null 2>&1; then
        echo "radicale:x:$(id -u):$(id -g):Radicale:/nonexistent:/sbin/nologin" >> /etc/passwd
    fi
    exec "$@"
fi
