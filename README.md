# Dockerfile for rsyslog server

Docker image supports 3 different roles: collector, relay and storage. You have to specify neccessary role via environment variable ROLE.

Examples:

    docker run --name rsyslog-collector \
      -v /data/logs:/var/log \
      --env ROLE=collector \
      --env RSYSLOG_FORWARD_IP=10.0.0.10 \
      --env RSYSLOG_FORWARD_PROTOCOL=udp \
      kam1kaze/rsyslog:latest

    docker run --name rsyslog-relay \
      --env ROLE=relay \
      --env RSYSLOG_FORWARD_IP=10.0.1.100 \
      --env RSYSLOG_FORWARD_PROTOCOL=tcp \
      --publish=514:514/udp \
      kam1kaze/rsyslog:latest

    docker run --name rsyslog-storage \
      --env ROLE=storage \
      --volume=/data/logs:/var/log \
      --publish=514:514 \
      kam1kaze/rsyslog:latest

As proof of concept, example directory contains terraform code that creates 3 EC2 nodes (one node per each role). So you could use them to 
perform some tests.
