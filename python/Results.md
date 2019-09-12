# Test results

## Platforms

### Windows

| code | release               | platform   | database engine (bits)                 | version |
|:-----------------------------|:-----------|:---------------------------------------|:-------|
| W1   | Windows 10 Pro (64)   | i7 (64)    | Actian PSQL v13 Server Engine SP2 (64) | 13.20 |

### Linux

| code | distribution          | platform   | database engine (bits)      | version |
|:-----|:----------------------|:-----------|:----------------------------|:--------|
| L1 | Debian Stretch (stable) | AMD64 (vm) | Actian PSQL v13 Server (64) | 13.31 |
| L2 | Raspbian Stretch (stable) | Raspberry Pi 3B+ | Actian PSQL V13 Server (32) | 13.20 |
| L3 | Debian Buster (stable) | AMD64 (vm) | Actian PSQL v13 Server (64) | 13.31 |
| L4 | Raspbian Buster (stable) | Raspberry Pi 3B+ | Actian PSQL V13 Server (32) | 13.20 |


Note: Using default kernels


## Results

| method        | layer  | platform | result |
|:--------------|:-------|:---------|:------|
| ODBC          | native | W1       | ? |
| ODBC          | native | L1       | ? |
| ODBC          | native | L2       | ? |
| ODBC          | native | L3       | ? |
| ODBC          | native | L4       | ? |
| ODBC DSN-less | native | W1       | ? |
| ODBC DSN-less | native | L1       | ? |
| ODBC DSN-less | native | L2       | ? |
| ODBC DSN-less | native | L3       | ? |
| ODBC DSN-less | native | L4       | ? |

