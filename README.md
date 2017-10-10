# rsyslog-poc

### How to deploy

    # install the latest version of terraform https://www.terraform.io/downloads.html
    # configure AWS API credentials https://www.terraform.io/docs/providers/aws/#environment-variables
    git clone https://github.com/kam1kaze/rsyslog-poc && cd rsyslog-poc
    terraform init
    terraform plan -out=tfplan
    terraform apply tfplan

### Test

    # Generate nginx access logs
    > for i in {0..30}; do curl -s -o /dev/null "http://$(terraform output worker_public_ip)/?q=$i" && echo -n . || echo -n F; done
    ...............................


    > ssh core@$(terraform output rsyslog_server_public_ip) sudo bash -c '"tail -f /data/logs/*/*"'
