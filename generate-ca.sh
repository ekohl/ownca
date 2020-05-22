#!/bin/bash -e

SUBJECT="${1:-/CN=OwnCA}"

touch certindex.txt
mkdir -p certs/
mkdir -p private/

openssl req -batch -new -x509 -config ./openssl.cnf \
	-subj "$SUBJECT" -extensions v3_ca -nodes \
	-keyout private/cakey.crt \
	-out cacert.crt -days 3650
