#!/bin/bash -e

export CERT_HOST=$1
if [[ -z $CERT_HOST ]] ; then
	echo "Usage: $0 CERT_HOST"
	exit 1
fi

mkdir $CERT_HOST
echo "[alt_names]" >> ./openssl.cnf
echo "DNS.1 = $CERT_HOST" >> ./openssl.cnf
cat <<EOF | openssl req -new -nodes -out ./$CERT_HOST/$CERT_HOST.crt.req\
  -keyout ./$CERT_HOST/$CERT_HOST.key -config ./openssl.cnf






$CERT_HOST
EOF

openssl ca -out ./$CERT_HOST/$CERT_HOST.crt -config ./openssl.cnf -infiles ./$CERT_HOST/$CERT_HOST.crt.req
sed -i '76,77d' ./openssl.cnf
