#!/usr/bin/env bash

# Install haproxy
yum install haproxy -y

# Configure haproxy
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

sudo service haproxy start

sudo firewall-cmd --zone=public --permanent --add-port=9000/tcp
sudo firewall-cmd --zone=public --permanent --add-port=8443/tcp
sudo firewall-cmd --zone=public --permanent --add-port=8080/tcp
sudo firewall-cmd --zone=public --permanent --add-port=8081/tcp
sudo firewall-cmd --zone=public --permanent --add-port=80/tcp
sudo service firewalld restart

# http://192.168.0.14:8080/haproxy?stats   To see the stats
