# rsyslog-server

docker run --rm -v /persistent_data:/var/log -p 514:514 -p 514:514/udp -d --name rsyslog-server rsyslog-server
