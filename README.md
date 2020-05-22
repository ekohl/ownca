# Own CA scripts

Set of scripts for setting up a custom CA for signing server
certificates. Not recommended for serious production.

## Installation

```console
$ wget https://raw.githubusercontent.com/ekohl/ownca/master/ownca
```

## Usage

Own CA can be executed from any directory and creates files the current working directory.

```bash
# generate a CA first
./ownca ca

# generate a server cert signed by this CA
./ownca cert my-server.example.com
```

## AUTHORS

Own CA was initially written by [@iNecas](https://github.com/iNecas) and currently maintained by [@ekohl](https://github.com/ekohl).
