#!/bin/bash

touch certindex.txt
mkdir certs/
mkdir private/

openssl req -new -x509 -extensions v3_ca -keyout \
private/cakey.crt -out cacert.crt -days 3650 -config ./openssl.cnf
echo "subjectAltName                          = @alt_names" >> ./openssl.cnf
