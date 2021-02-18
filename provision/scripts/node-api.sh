#!/bin/bash

# create self-signed SSL cert
openssl req -new -nodes -x509 -sha256 -subj "/C=UK/ST=England/L=London/O=Graadisoft/CN=tomcat8-02.dev.internal" -days 3650 -newkey rsa:2048 -keyout /opt/tomcat/tomcat8-02.dev.internal.key -out /opt/tomcat/tomcat8-02.dev.internal.crt

# name: create PKCS12
openssl pkcs12 -export -name tomcat8-02.dev.internal -in /opt/tomcat/tomcat8-02.dev.internal.crt -inkey /opt/tomcat/tomcat8-02.dev.internal.key -out /opt/tomcat/tomcat8-02.dev.internal.p12 -password pass:"changeit"

# create Keystore and Import PKCS12 Cert/Key pair
keytool -importkeystore -srcstorepass "changeit" -deststorepass "changeit" -destkeystore /opt/tomcat/"tomcat8-02.dev.internal".jks -srckeystore /opt/tomcat/"tomcat8-02.dev.internal".p12 -srcstoretype pkcs12 -alias "tomcat8-02.dev.internal"

# temp folder
sudo mkdir -p /var/neo/api/temp/

# properties
sudo mkdir -p /var/api
sudo cp '/opt/vagrant/api/properties/authentication-api.properties' '/var/api/api.properties'

# artifacts (jar)
sudo mkdir -p /home/api
sudo cp '/opt/vagrant/api/artifacts/background-processor.jar' '/home/api/background-processor.jar'

# artifacts (war)
sudo cp '/opt/vagrant/api/artifacts/api.war' '/opt/tomcat/webapps/api.war'

# tomcat configuration
sudo cp '/opt/vagrant/api/tomcat/server.xml' '/opt/tomcat/conf/server.xml'
sudo cp '/opt/vagrant/api/tomcat/context.xml' '/opt/tomcat/conf/context.xml'

# restart tomcat
sudo systemctl restart tomcat.service
