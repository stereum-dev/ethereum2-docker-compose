# Prysm node

## Requirements
* Get to know [Prysm](https://docs.prylabs.network/docs/getting-started/) a bit
* Server with 4 (v)cpus & 8 gb memory & 250 gb storage

## Services
* [geth](https://github.com/ethereum/go-ethereum)
* beacon
* validator
* prometheus
* grafana

**All services are enabled by default.**

### Minimal Setup (beacon & validator only)
In case you want to run only beacon & validator (geth, slasher, prometheus, grafana get disabled) move the `./compose-examples/prysm-only/override-examples/docker-compose.beacon-validator.override.yaml` file in the same folder as your `docker-compose.yaml` and rename it to `docker-compose.override.yaml`. Read up on [docker-compose files & override](https://docs.docker.com/compose/extends/#multiple-compose-files) to customize your setup further.

## (optional) Configure your node

### Public ip & other Prysm parameters/arguments
Configuration files are located in the folder `./config`. To gain a better connectivity for your beacon node you should specifiy your public ip and/or your dns name in `./config/prysm/beacon.yaml`. Follow the guide [Improve Peer-to-Peer Connectivity](https://docs.prylabs.network/docs/prysm-usage/p2p-host-ip/).

## Validator accounts with launchpad

Please complete the steps on [launchpad](https://pyrmont.launchpad.ethereum.org/) 

1. Generate your validator(s) using [launchpad](https://prater.launchpad.ethereum.org/) and complete the process
2. Copy your generated validator(s) from `~/eth2.0-deposit-cli/validator_keys` to `./launchpad`
3. Put your wallet password in `./data/prysm/validator/passwords/wallet-password`
4. Run `./prysm_validator_import.sh <ValidatorPassword>` Put your validator password instead `<ValidatorPassword>`
5. Run `docker-compose stop validator` then `docker-compose up -d validator` to restart validator service

For instance: `./prysm_validator_exit.sh MyPassword` 

The "Expect" needs to be installed to execute `prysm_validator_import.sh`. Run `apt-get install expect` to install expect on Ubuntu

## Validator accounts voluntary exit

The Beacon node needs to be fully synced to implement voluntary exit of validator!

1. Run `./prysm_validator_exit.sh <ValidatorPublicKey>` Put your validator public key instead `<ValidatorPublicKey>`
2. Run `docker-compose stop validator` then `docker-compose up -d validator` to restart validator service

For instance: `./prysm_validator_exit.sh 0xabcde12345...`

The "Expect" needs to be installed to execute `prysm_validator_exit.sh`. Run `apt-get install expect` to install expect on Ubuntu

## Validator accounts delete 

1. Run `./prysm_validator_delete.sh <ValidatorPublicKey>` Put your validator public key instead `<ValidatorPublicKey>`
2. Run `docker-compose stop validator` then `docker-compose up -d validator` to restart validator service

For instance: `./prysm_validator_delete.sh 0xabcde12345...`

The "Expect" needs to be installed to execute `prysm_validator_delete.sh`. Run `apt-get install expect` to install expect on Ubuntu


## Run your Prysm Ethereum 2.0 staking node

### Start it up
Run with (as deamon with "-d")
```
docker-compose up -d
```
or run only certain services (in this case only beacon and validator)
```
docker-compose up -d beacon validator
```

### Stop it
Stop services (or everything) like this
```
docker-compose stop validator slasher
```

### Shut it down for good
Shut down your services (or everything) like this:
```
docker-compose down
```
Please note: This will also erase your logs, they are stored with your containers and will be deleted as well.

## Monitoring
### Logging
Docker takes care of log files and log file rotation as well as limit (set to 10x100mb log files for each service).
View logs of a certain service (in this case beacon, only the last 100 lines)
```
docker-compose logs --tail=100 beacon
```

### Prometheus
Runs on http://localhost:9090, scrapes data of beacon, validator and slasher.

### Grafana
Grafana listens on http://localhost:3000 and uses the data provided by prometheus service.

Login with username `admin` and password `admin` (Grafana defaults), data source to Prometheus is already established and dashboards installed.

### Prysm Web Interface
Runs on http://localhost:7500, a wallet is already created then signup with your web interface password.

If not, use `Imported Wallet` option to import the your keystores & set your web interface password.

## FAQ
### I keep missing attestations or keep getting warnings/errors about `roughtime`
E. g. error messages like this:
```
WARN roughtime: Roughtime reports your clock is off by more than 2 seconds offset=4h0m0.345549475s
```
Make sure the OS' clock is synced. For Windows 10 and its subsystem linux might run on different times, to check this run `wsl` and then `date` (may differ by the OS you have installed).

Ask google on how to get your OS' time synced again.

### I want to use a specific Ethereum 1 node!
Edit the line with `http-web3provider` in [./config/prysm/beacon.yaml](/config/prysm/beacon.yaml) and set your Ethereum 1 node URL, e. g. use it with [Infura.io](https://infura.io/) and make it look like this: `http-web3provider: "https://goerli.infura.io:443/v3/put-your-infura-id-here"` (make sure to use `""` for the url).
