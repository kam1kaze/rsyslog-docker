#!/usr/bin/env bash

set -ex -o nounset

mv -v /etc/rsyslog.d/"${ROLE}".conf{.disabled,}

while IFS='=' read -r key value; do
  sed -ri "s/%%${key}%%/${value}/g" /etc/rsyslog.d/"${ROLE}".conf
done < <(env | grep ^RSYSLOG_)

exec "$@"
