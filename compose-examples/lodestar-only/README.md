# Lodestar

## Requirements
* Get to know [Lodestar](https://chainsafe.github.io/lodestar/) a bit
* Server with 4 (v)cpus & 8 gb memory & 150 gb storage

## Services
* geth (beacon connects to it to see deposits for validators)
* beacon
* validator (doesn't validate at the moment: [issue #1941](https://github.com/ChainSafe/lodestar/issues/1941))
* prometheus
* grafana

**All services are enabled by default.**

## Validator accounts with launchpad
Please complete the steps on [launchpad](https://pyrmont.launchpad.ethereum.org/) and store the generated files of `~/eth2.0-deposit-cli/validator_keys` in `./launchpad/eth2.0-deposit-cli/validator_keys`. 

1. Generate your validator(s) using [launchpad](https://pyrmont.launchpad.ethereum.org/) and complete the process
2. Copy your generated validator(s) from `~/eth2.0-deposit-cli/validator_keys` to `./launchpad/eth2.0-deposit-cli/validator_keys`
3. Run `docker-compose -f create-account.yaml run validator-import-launchpad` and use the **same password** as in the generation of the validator(s)

You'll be asked to provide password for each validator

You can repeat step 2 & 3 as often as you like, make sure to restart your validator to make it notice your new accounts!

## Run your lodestar Ethereum 2.0 beacon node

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
docker-compose stop beacon
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
Runs on http://localhost:9096, scrapes data of beacon & validator.

### Grafana
Grafana listens on http://localhost:3006 and uses the data provided by prometheus service.

Login with username `admin` and password `admin` (Grafana defaults), data source to Prometheus is already established and dashboards installed.
