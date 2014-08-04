#!/bin/bash

export CERT_HOST=$1
mkdir $CERT_HOST

cat <<EOF | openssl req -new -nodes -out ./$CERT_HOST/$CERT_HOST.crt.req\
  -keyout ./$CERT_HOST/$CERT_HOST.key -config ./openssl.cnf






$CERT_HOST
EOF

openssl ca -out ./$CERT_HOST/$CERT_HOST.crt -config ./openssl.cnf -infiles ./$CERT_HOST/$CERT_HOST.crt.req
