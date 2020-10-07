# ethereum2-docker-compose

This docker-compose includes all parts to run and monitor an Ethereum 2.0 staking node. It uses multiple clients.

## Services

### Ethereum 1
* Go Ethereum (geth)

### Ethereum 2
* Prysm beacon node
* Lighthouse beacon node
* Teku beacon node

* Vouch
* Dirk

### Monitoring
* prometheus
* grafana (wip)

**All services are enabled by default.**

## Setup

### Certificates
Generate a client certificate for vouch and a server certificate for dirk. There are a number of ways to generate them, one way is the use of [easy-rsa](https://help.endian.com/hc/en-us/articles/360009201753-How-to-generate-and-import-CA-Server-and-Client-certificates-from-an-external-host). Copy the certificates to:

* `./config/vouch/certs/ca.crt` CA public key of server certificate for **dirk**
* `./config/vouch/certs/vouch.crt` public key of server certificate for vouch (CN=vouch)
* `./config/vouch/certs/vouch.key` private key of server certificate for vouch

* `./config/dirk/certs/ca.crt` CA public key of server certificate for dirk
* `./config/dirk/certs/dirk.crt` public key of server certificate for dirk (CN=dirk)
* `./config/dirk/certs/dirk.key` private key of server certificate for dirk

### Wallets
Vouch and dirk need to be aware of the wallets. Copy the [ethdo](https://github.com/wealdtech/ethdo) wallet(s) to `./wallets` and adapt the following files:
* `./config/vouch/vouch.yml`: edit `accountmanager.dirk.accounts` and list the wallets. Take a look at the [vouch github](https://github.com/attestantio/vouch/blob/master/docs/accountmanager.md#accounts) for more details.
* (optional) `./config/dirk/dirk.yml`: edit `permissions.vouch`, default is to give access to all wallets/accounts. Read up details on the [dirk github](https://github.com/attestantio/dirk/blob/master/docs/permissions.md)

Edit the following files to allow dirk to decrypt the wallet/accounts with passwords:
* `./config/dirk/passphrases/account-passphrase.txt`
* `config/dirk/passphrases/wallet-passphrase.txt`

## Monitoring

### Prometheus
Runs on http://localhost:9090, scrapes data of geth, beacon nodes, vouch and dirk.

### Grafana
Grafana listens on http://localhost:3000 and uses the data provided by prometheus service.

Login with username `admin` and password `admin` (Grafana defaults), data source to Prometheus is already established and dashboards installed.

## FAQ
### My `docker-compose` command doesn't work (e. g. `ERROR: Version in "./docker-compose.yaml" is unsupported.`)
Most linux distributions (including Ubuntu) don't serve recent docker-compose versions in their package management. You can install a compatible version by following [official docker.io documentation](https://docs.docker.com/compose/install/).

## Support the maintainer
This software is provided under MIT license and therefore freely usable without restrictions. Dontations are always welcome:

ETH - 0xA1DDc7ed6E7b9179C68cDEE24a5e47dE930061eE

BTC - 39n4LUxbcCfJvBGvFVVwQQkGxSJ44JRYV7
