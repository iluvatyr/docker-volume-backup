FROM alpine:latest
MAINTAINER iluvatyr

RUN apk add --no-cache rsync tzdata
ENV TZ=Europe/Berlin
WORKDIR /volumes
LABEL description="Daily docker volume backup @4:00 am"
RUN echo "0 4 * * * run-parts /etc/periodic/daily" > /etc/crontabs/root
RUN mkdir /logs
COPY rsync-volumes.sh /etc/periodic/daily
RUN chmod +x /etc/periodic/daily/rsync-volumes.sh
CMD crond -f -l 8
