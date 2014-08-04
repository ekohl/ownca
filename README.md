# Own CA scripts

Set of scripts for setting up a custom CA for signing server
certificates. Not recommended for serious production.

## Usage

```bash
# generate a CA first
./generate-ca.sh

# generate a server cert signed by this CA
./generate-crt.sh my-server.example.com
```
