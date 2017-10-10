# rsyslog-poc

### How to deploy

    # install the latest version of terraform https://www.terraform.io/downloads.html
    # configure AWS API credentials https://www.terraform.io/docs/providers/aws/#environment-variables
    git clone https://github.com/kam1kaze/rsyslog-poc && cd rsyslog-poc/terraform
    terraform init
    terraform plan -out=tfplan
    terraform apply tfplan

### Test

    # Generate nginx access logs
    > for i in {0..30}; do curl -s -o /dev/null "http://$(terraform output worker_public_ip)/?q=$i" && echo -n . || echo -n F; done
    ...............................

    # Check centralized log server for logs
    > ssh core@$(terraform output rsyslog_server_public_ip) sudo bash -c '"tail -v /data/logs/*/*"'
    Warning: Permanently added '18.194.193.134' (ECDSA) to the list of known hosts.
    ==> /data/logs/9cb5aacfc0e2/2017-10-10.log <==
    Oct 10 00:26:44 9cb5aacfc0e2 apps: 178.150.91.88 - - [10/Oct/2017:00:26:44 +0000] "GET /?q=21 HTTP/1.1" 200 612 "-" "curl/7.54.0" "-"
    Oct 10 00:26:45 9cb5aacfc0e2 apps: 178.150.91.88 - - [10/Oct/2017:00:26:45 +0000] "GET /?q=22 HTTP/1.1" 200 612 "-" "curl/7.54.0" "-"
    Oct 10 00:26:45 9cb5aacfc0e2 apps: 178.150.91.88 - - [10/Oct/2017:00:26:45 +0000] "GET /?q=23 HTTP/1.1" 200 612 "-" "curl/7.54.0" "-"
    Oct 10 00:26:45 9cb5aacfc0e2 apps: 178.150.91.88 - - [10/Oct/2017:00:26:45 +0000] "GET /?q=24 HTTP/1.1" 200 612 "-" "curl/7.54.0" "-"
    Oct 10 00:26:45 9cb5aacfc0e2 apps: 178.150.91.88 - - [10/Oct/2017:00:26:45 +0000] "GET /?q=25 HTTP/1.1" 200 612 "-" "curl/7.54.0" "-"
    Oct 10 00:26:45 9cb5aacfc0e2 apps: 178.150.91.88 - - [10/Oct/2017:00:26:45 +0000] "GET /?q=26 HTTP/1.1" 200 612 "-" "curl/7.54.0" "-"
    Oct 10 00:26:45 9cb5aacfc0e2 apps: 178.150.91.88 - - [10/Oct/2017:00:26:45 +0000] "GET /?q=27 HTTP/1.1" 200 612 "-" "curl/7.54.0" "-"
    Oct 10 00:26:45 9cb5aacfc0e2 apps: 178.150.91.88 - - [10/Oct/2017:00:26:45 +0000] "GET /?q=28 HTTP/1.1" 200 612 "-" "curl/7.54.0" "-"
    Oct 10 00:26:46 9cb5aacfc0e2 apps: 178.150.91.88 - - [10/Oct/2017:00:26:46 +0000] "GET /?q=29 HTTP/1.1" 200 612 "-" "curl/7.54.0" "-"
    Oct 10 00:26:46 9cb5aacfc0e2 apps: 178.150.91.88 - - [10/Oct/2017:00:26:46 +0000] "GET /?q=30 HTTP/1.1" 200 612 "-" "curl/7.54.0" "-"
