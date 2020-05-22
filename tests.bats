#!/usr/bin/env bats

setup() {
        PATH="$BATS_TEST_DIRNAME:$PATH"
        WORKDIR=$(mktemp -d)
        cp openssl.cnf "$WORKDIR/"
        cd "$WORKDIR" || exit
}

teardown() {
        rm -rf "$WORKDIR"
}

@test "Generate CA" {
        generate-ca.sh
        test -f certindex.txt
        test -d certs
        test -d private
        test -f private/cakey.crt
        openssl x509 -in cacert.crt -noout -text | grep "Subject: CN = OwnCA"
}

@test "Generate CA with custom subject" {
        generate-ca.sh "/C=NL/CN=My Custom CA"
        test -f certindex.txt
        test -d certs
        test -d private
        test -f private/cakey.crt
        openssl x509 -in cacert.crt -noout -text | grep "Subject: C = NL, CN = My Custom CA"
}

@test "Generate certificate" {
        generate-ca.sh
        generate-crt.sh host.example.com

        echo
        echo "Generated certificate - verifying"
        test -f host.example.com/host.example.com.req
        test -f host.example.com/host.example.com.key
        test -f host.example.com/host.example.com.crt
        openssl x509 -in host.example.com/host.example.com.crt -noout -text
        openssl x509 -in host.example.com/host.example.com.crt -noout -text | grep -q "Issuer: CN = OwnCA"
        openssl x509 -in host.example.com/host.example.com.crt -noout -text | grep -q "Subject: CN = host.example.com"
        openssl x509 -in host.example.com/host.example.com.crt -noout -text | grep -q "DNS:host.example.com"
}
