FROM alpine:3.6

RUN apk add --no-cache rsyslog

COPY rsyslog.conf /etc/

EXPOSE 514/tcp 514/udp

CMD ["rsyslogd", "-n"]
