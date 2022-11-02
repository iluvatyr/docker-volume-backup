FROM alpine:latest
MAINTAINER iluvatyr
ENV PUID="1337" \
    PGID="1337" \
    USERNAME="volume-backup" \
    GROUPNAME="volume-backup"

## Installing necessary packages
## rsync for backing up, curl and ca-certificates for monitoring via uptime-kuma or other push-URL services
RUN apk add --no-cache rsync tzdata curl ca-certificates sudo

COPY rsync_volumes.sh entrypoint.sh uptime_push.sh delete_old_logs.sh /app/
RUN chmod 500 /app/*
RUN mkdir /volumes /var/log/volume-backup

WORKDIR /app
VOLUME ["/var/log/volume-backup"]
ENTRYPOINT ["/app/entrypoint.sh"]
