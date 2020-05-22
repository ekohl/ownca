#!/usr/bin/env bats

setup() {
        PATH="$BATS_TEST_DIRNAME:$PATH"
        WORKDIR=$(mktemp -d)
        cd "$WORKDIR" || exit
}

teardown() {
        rm -rf "$WORKDIR"
}

@test "Run without arguments" {
        run ownca
        [[ $status == 1 ]]
}

@test "Generate CA" {
        ownca ca
        test -f certindex.txt
        test -d certs
        test -d private
        test -f private/cakey.crt
        openssl x509 -in cacert.crt -noout -text | grep "Subject: CN = OwnCA"
}

@test "Generate CA with custom subject" {
        ownca ca "/C=NL/CN=My Custom CA"
        test -f certindex.txt
        test -d certs
        test -d private
        test -f private/cakey.crt
        openssl x509 -in cacert.crt -noout -text | grep "Subject: C = NL, CN = My Custom CA"
}

@test "Call cert without an argument" {
        run ownca cert
        [[ $status == 1 ]]
}

@test "Call cert without a CA" {
        run ownca cert host.example.com
        [[ $status == 2 ]]
}

@test "Generate certificate" {
        ownca ca
        ownca cert host.example.com

        echo
        echo "Generated certificate - verifying"
        test -f serial
        test -f host.example.com/host.example.com.req
        test -f host.example.com/host.example.com.key
        test -f host.example.com/host.example.com.crt
        openssl x509 -in host.example.com/host.example.com.crt -noout -text
        openssl x509 -in host.example.com/host.example.com.crt -noout -text | grep -q "Issuer: CN = OwnCA"
        openssl x509 -in host.example.com/host.example.com.crt -noout -text | grep -q "Subject: CN = host.example.com"
        openssl x509 -in host.example.com/host.example.com.crt -noout -text | grep -q "DNS:host.example.com"
}
