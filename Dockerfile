FROM alpine:3.6

ENV RSYSLOG_FORWARD_PORT 514
ENV RSYSLOG_FORWARD_PROTOCOL UDP

RUN apk add --no-cache \
  bash \
  rsyslog

COPY rsyslog.conf /etc/
COPY rsyslog.d/* /etc/rsyslog.d/
COPY entrypoint.sh /usr/sbin/

RUN ["mkdir", "-p", "/var/spool/rsyslog"]

ENTRYPOINT ["entrypoint.sh"]

CMD ["rsyslogd", "-n"]
