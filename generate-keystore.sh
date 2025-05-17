#!/bin/bash

mkdir -p /usr/local/tomcat/ssl

keytool -genkeypair \
  -alias tomcat \
  -keyalg RSA \
  -keysize 2048 \
  -validity 365 \
  -keystore /usr/local/tomcat/ssl/keystore.p12 \
  -storetype PKCS12 \
  -storepass 123456 \
  -keypass 123456 \
  -dname "CN=localhost, OU=Dev, O=MyCompany, L=HCM, ST=HCM, C=VN"
