# Lighthouse standalone fullstack

## Requirements
* Get to know [Lighthouse](https://lighthouse-book.sigmaprime.io/) a bit
* Server with 4 (v)cpus & 8 gb memory & 100 gb storage

## Services
* geth (beacon conntects to it to see deposits for validators)
* beacon
* validator

**All services are enabled by default.**

## Configure your node

## Validator accounts with launchpad
Please complete the steps on [launchpad](https://medalla.launchpad.ethereum.org/) and store the generated files of `~/eth2.0-deposit-cli/validator_keys` in `./launchpad`.

1. Generate your validator(s) using [launchpad](https://medalla.launchpad.ethereum.org/) and complete the process
2. Copy your generated validator(s) from `~/eth2.0-deposit-cli/validator_keys` to `./launchpad`
3. Run `docker-compose -f create-account.yaml run validator-import-launchpad` and use the **same password** as in the generation of the validator(s)
4. Run `docker-compose up validator` to create the directory structure for the validators. You may cancel after startup
5. Copy `./wallets/validators/validator_definitions.yml` to `./wallets/medalla/validators/validator_definitions.yml`

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
Todo

### Grafana
Todo

## FAQ
### I want to use a specific Ethereum 1 node!
Todo