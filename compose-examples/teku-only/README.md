# Teku standalone 

## Requirements
* Get to know [Teku](https://docs.teku.consensys.net/en/latest/) a bit
* Server with 4 (v)cpus & 8 gb memory & 100 gb storage

## Services
* [geth](https://github.com/ethereum/go-ethereum)
* beacon (with validator)
* prometheus
* grafana

**All services are enabled by default.**

## Configure your node

## Validator accounts with launchpad
Please complete the steps on [launchpad](https://pyrmont.launchpad.ethereum.org/) and store the generated files of `~/eth2.0-deposit-cli/validator_keys` in `./launchpad`.

1. Generate your validator(s) using [launchpad](https://pyrmont.launchpad.ethereum.org/) and complete the process
2. Copy your generated validator(s) from `~/eth2.0-deposit-cli/validator_keys` to `./launchpad`
3. Create the validator password files in `./launchpad`. For each validator `keystore-m_xxx.json` key file a corresponding password txt file is required. The password file will need to be named to match the corresponding `keystore-m_xxx.txt` file.

Repeat these steps as often as you like, restart your validator to make it notice your new accounts!

## Run your Teku Ethereum 2.0 staking node

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
Runs on http://localhost:9094, scrapes data of beacon and validator.

### Grafana
Grafana listens on http://localhost:3004 and uses the data provided by prometheus service.

Login with username `admin` and password `admin` (Grafana defaults), data source to Prometheus is already established and dashboards installed.

## FAQ

### I want to use a specific Ethereum 1 node!
Edit the line with `eth1-endpoint:` in [./config/teku/beacon.yaml](/config/teku/beacon.yaml) and set your Ethereum 1 node URL, e. g. use it with [Infura.io](https://infura.io/) and make it look like this: `eth1-endpoint: https://goerli.infura.io:443/v3/put-your-infura-id-here`.
