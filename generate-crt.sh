#!/bin/bash -e

export CERT_HOST=$1
if [[ -z $CERT_HOST ]] ; then
	echo "Usage: $0 CERT_HOST"
	exit 1
fi

if [[ ! -e private/cakey.crt ]] ; then
	echo "First generate a CA using generate-ca.sh"
	exit 2
fi

mkdir $CERT_HOST
openssl req -new -nodes \
	-subj "/CN=$CERT_HOST" \
	-addext "subjectAltName = DNS:$CERT_HOST" \
	-out "./$CERT_HOST/$CERT_HOST.req" \
	-keyout "./$CERT_HOST/$CERT_HOST.key"

openssl ca -batch -config ./openssl.cnf \
	-in "./$CERT_HOST/$CERT_HOST.req" \
	-out "./$CERT_HOST/$CERT_HOST.crt"
