FROM alpine:3.6

RUN apk add --no-cache rsyslog

COPY rsyslog.conf /etc/
COPY entrypoint.sh /usr/sbin/

RUN ["mkdir", "-p", "/var/spool/rsyslog"]

VOLUME ["/var/log"]

ENTRYPOINT ["entrypoint.sh"]

CMD ["rsyslogd", "-n"]
