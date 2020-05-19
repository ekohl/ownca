#!/bin/bash -e

export CERT_HOST=$1
if [[ -z $CERT_HOST ]] ; then
	echo "Usage: $0 CERT_HOST"
	exit 1
fi

mkdir $CERT_HOST
openssl req -new -nodes \
	-subj "/CN=$CERT_HOST" \
	-addext "subjectAltName = DNS:$CERT_HOST" \
	-out ./$CERT_HOST/$CERT_HOST.crt.req\
	-keyout ./$CERT_HOST/$CERT_HOST.key

openssl ca -out ./$CERT_HOST/$CERT_HOST.crt -config ./openssl.cnf -infiles ./$CERT_HOST/$CERT_HOST.crt.req
