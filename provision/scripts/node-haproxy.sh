#!/usr/bin/env bash

# prerequisites
sudo apt-get update

# install loadbalancer
sudo apt-get install haproxy -y

# configuration
cat > /etc/default/haproxy <<EOD
# Set ENABLED to 1 if you want the init script to start haproxy.
ENABLED=1
# Add extra flags here.
#EXTRAOPTS="-de -m 16"
EOD

cat > /etc/haproxy/haproxy.cfg <<EOD
global
    daemon
    maxconn 256
defaults
    mode http
    timeout connect 5000ms
    timeout client 50000ms
    timeout server 50000ms
frontend http-in
        bind *:8080
        acl  has_special_uri path_beg /api
        use_backend tomcatssl if has_special_uri
        default_backend tomcatweb

backend tomcatweb
        balance roundrobin
        # Poor-man's sticky balance source
        # JSP SessionID Sticky appsession JSESSIONID len 52 timeout 3h
        option httpchk
        option forwardfor
        option http-server-close
        server tomcat8-01.dev.internal 192.168.0.30:8080 maxconn 32 check

backend tomcatssl
       balance roundrobin
       option forwardfor
       server tomcat8-02.dev.internal 192.168.0.31:8080 maxconn 32 check

listen admin
    bind *:9000
    stats enable
EOD

# verify configuration
sudo haproxy -c -f /etc/haproxy/haproxy.cfg

# service status
sudo systemctl enable haproxy
sudo service haproxy status
