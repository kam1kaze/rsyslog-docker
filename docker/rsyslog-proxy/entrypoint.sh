#!/bin/sh

set -ex
set -o nounset

sed -ri "s/%%REMOTE_ADDR%%/${REMOTE_ADDR}/g" /etc/rsyslog.conf

exec "$@"
