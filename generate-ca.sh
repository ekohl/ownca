#!/bin/bash -e

touch certindex.txt
mkdir -p certs/
mkdir -p private/

openssl req -new -x509 -extensions v3_ca -keyout \
private/cakey.crt -out cacert.crt -days 3650 -config ./openssl.cnf
