# Lighthouse node

## Requirements
* Get to know [Lighthouse](https://lighthouse-book.sigmaprime.io/) a bit
* Server with 4 (v)cpus & 8 gb memory & 100 gb storage

## Services
* [geth](https://github.com/ethereum/go-ethereum)
* beacon (including slasher)
* validator
* prometheus
* grafana

**All services are enabled by default.**

## Configure your node

## Validator accounts with launchpad
Please complete the steps on [launchpad](https://prater.launchpad.ethereum.org/) and store the generated files of `~/eth2.0-deposit-cli/validator_keys` in `./launchpad`.

1. Generate your validator(s) using [launchpad](https://prater.launchpad.ethereum.org/) and complete the process
2. Copy your generated validator(s) from `~/eth2.0-deposit-cli/validator_keys` to `./launchpad`
3. Run `docker-compose -f create-account.yaml run validator-import-launchpad` and use the **same password** as in the generation of the validator(s)

Repeat these steps as often as you like, restart your validator to make it notice your new accounts!

## Validator accounts voluntary exit

1. Copy `exit-account.yaml` to the project's root directory (this directory)
2. Run `docker-compose -f exit-account.yaml run -e LAUNCHPADDIR='/opt/app/launchpad/keystore-m_12381...json' exit-validator` and use the **same password** as in the generation of the validator(s)

For instance: `docker-compose -f exit-account.yaml run -e LAUNCHPADDIR='/opt/app/launchpad/keystore-m_12381_3600_0_0_0-123456789.json' exit-validator`

## Run your Lighthouse Ethereum 2.0 staking node

### Start it up
Run with (as deamon with "-d")
```
docker-compose up -d
```
or run only certain services (in this case only beacon)
```
docker-compose up -d beacon
```

### Stop it
Stop services (or everything) like this
```
docker-compose stop validator
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

Login with username `admin` and password `admin` (Grafana defaults), data source to Prometheus is already established and dashboards installed (source of dashboards: [lighthouse-metrics](https://github.com/sigp/lighthouse-metrics)).

## FAQ
### I want to use a specific Ethereum 1 node, like Infura.io!
1. Edit `./config/lighthouse/beacon.env` and set `ETH1_NODES=` to your external Ethereum 1 node, e. g. `ETH1_NODES=https://goerli.infura.io:443/v3/put-your-infura-id-here`.
2. Copy `./compose-examples/lighthouse-only/override-examples/docker-compose.no-geth.override.yaml` to `./docker-compose.override.yaml`. This will disable geth for your node.
