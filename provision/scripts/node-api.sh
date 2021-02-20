#!/bin/bash

# create self-signed SSL cert
sudo openssl req -new -nodes -x509 -sha256 -subj "/C=UK/ST=England/L=London/O=SampleOrg/CN=tomcat.dev.internal" -days 3650 -newkey rsa:2048 -keyout /opt/tomcat/tomcat.dev.internal.key -out /opt/tomcat/tomcat.dev.internal.crt

# name: create PKCS12
sudo openssl pkcs12 -export -name tomcat.dev.internal -in /opt/tomcat/tomcat.dev.internal.crt -inkey /opt/tomcat/tomcat.dev.internal.key -out /opt/tomcat/tomcat.dev.internal.p12 -password pass:"changeit"

# create Keystore and Import PKCS12 Cert/Key pair
sudo keytool -importkeystore -srcstorepass "changeit" -deststorepass "changeit" -destkeystore /opt/tomcat/"tomcat.dev.internal".jks -srckeystore /opt/tomcat/"tomcat.dev.internal".p12 -srcstoretype pkcs12 -alias "tomcat.dev.internal"

# tomcat configuration
sudo cp '/opt/vagrant/api/tomcat/server.xml' '/opt/tomcat/conf/server.xml'
sudo cp '/opt/vagrant/api/tomcat/context.xml' '/opt/tomcat/conf/context.xml'

# restart tomcat
sudo systemctl restart tomcat.service
