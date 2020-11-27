# Multiclient with Vouch & Dirk

## Requirements
* Understanding of TLS/SSL and how to create CA, issue certificates
* Intermediate knowledge of Ethereum (1 & 2)
* Server with a minimum of 6 cores/12 threads & 32 gb memory & 256 gb of storage

## Services

### Ethereum 1
* Go Ethereum (geth)

### Ethereum 2
* Prysm beacon node
* Lighthouse beacon node
* Teku beacon node

* Additional Prysm beacon node (for slasher)
* Prysm slasher

* Vouch
* Dirk

### Monitoring
* prometheus
* grafana

**All services are enabled by default.**

## Setup

### (optional) Certificates
There are pregenerated certificates to kickstart this installation faster for try-out. However, it is **strongly** adviced to generate your own certificates especially for mainnet. Generate a client certificate for vouch and a server certificate for dirk. These certificates won't be accessible from outside, they are only visible to vouch and dirk. There are a number of ways to generate them, one way is the use of [easy-rsa](https://help.endian.com/hc/en-us/articles/360009201753-How-to-generate-and-import-CA-Server-and-Client-certificates-from-an-external-host). Copy the certificates to:

**Vouch**
* `./config/vouch/certs/ca.crt` CA public key of server certificate for **dirk**
* `./config/vouch/certs/vouch.crt` public key of server certificate for vouch (CN=vouch)
* `./config/vouch/certs/vouch.key` private key of server certificate for vouch

**Dirk**
* `./config/dirk/certs/ca.crt` CA public key of server certificate for dirk
* `./config/dirk/certs/dirk.crt` public key of server certificate for dirk (CN=dirk)
* `./config/dirk/certs/dirk.key` private key of server certificate for dirk

### Wallets
Vouch and dirk need to be aware of the wallets. Copy the [ethdo](https://github.com/wealdtech/ethdo) wallet(s) to `./wallets` and adapt the following files:
* `./config/vouch/vouch.yml`: edit `accountmanager.dirk.accounts` and list the wallets. Take a look at the [vouch github](https://github.com/attestantio/vouch/blob/master/docs/accountmanager.md#accounts) for more details.
* (optional) `./config/dirk/dirk.yml`: edit `permissions.vouch`, default is to give access to all wallets/accounts. Read up details on the [dirk github](https://github.com/attestantio/dirk/blob/master/docs/permissions.md)

Edit the following files to allow dirk to decrypt the wallet/accounts with passwords:
* `./config/dirk/passphrases/account-passphrase.txt`
* `./config/dirk/passphrases/wallet-passphrase.txt`

## Monitoring

### Prometheus
Runs on http://localhost:9090, scrapes data of geth, beacon nodes, vouch and dirk.

### Grafana
Grafana listens on http://localhost:3000 and uses the data provided by prometheus service.

Login with username `admin` and password `admin` (Grafana defaults), data source to Prometheus is already established and dashboards installed.

It's possible an error occures when starting up grafana:
```
grafana_1     | GF_PATHS_DATA='/var/lib/grafana' is not writable.
grafana_1     | You may have issues with file permissions, more information here: http://docs.grafana.org/installation/docker/#migration-from-a-previous-version-of-the-docker-container-to-5-1-or-later
grafana_1     | mkdir: can't create directory '/var/lib/grafana/plugins': Permission denied
```
Adding `user: <your-user-id>` to the service `grafana` in your `docker-compose.yaml` resolves this. Run `id -u` to get your user-id on linux.
