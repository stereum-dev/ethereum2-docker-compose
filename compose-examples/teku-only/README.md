# Teku standalone 

## Requirements
* Get to know [Teku](https://docs.teku.consensys.net/en/latest/) a bit
* Server with 4 (v)cpus & 8 gb memory & 100 gb storage

## Services
* [geth](https://github.com/ethereum/go-ethereum)
* beacon (including validator)
* prometheus
* grafana

**All services are enabled by default.**

## Configure your node

## Validator accounts with launchpad
Please complete the steps on [launchpad](https://prater.launchpad.ethereum.org/) and store the generated files of `~/eth2.0-deposit-cli/validator_keys` in `./launchpad`.

1. Generate your validator(s) using [launchpad](https://prater.launchpad.ethereum.org/) and complete the process
2. Copy your generated validator(s) from `~/eth2.0-deposit-cli/validator_keys` to `./launchpad`
3. Create the validator password files in `./launchpad`. For each validator `keystore-m_123....json` key file a corresponding password `keystore-m_123....txt` file is required. The password file will need to be named to match the correlating keystore file.

Repeat these steps as often as you like, restart your validator to make it notice your new accounts!

## Validator accounts voluntary exit

1. Copy `exit-account.yaml` to the project's root directory (this directory)
2. Run `./teku_validator_exit.sh name-of-keystore-without-extension`

For instance: If a keystore file is `keystore-m_12381_3600_0_0_0-123456789.json` then the command should be `./teku_validator_exit.sh keystore-m_12381_3600_0_0_0-123456789`

The "Expect" needs to be installed to execute `teku_validator_exit.sh`. Run `apt-get install expect` to install expect

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
Runs on http://localhost:9090, scrapes data of beacon and validator.

### Grafana
Grafana listens on http://localhost:3000 and uses the data provided by prometheus service.

Login with username `admin` and password `admin` (Grafana defaults), data source to Prometheus is already established and dashboards installed.

## FAQ

### I want to use a specific Ethereum 1 node!
Edit the line with `eth1-endpoint:` in [./config/teku/beacon.yaml](/config/teku/beacon.yaml) and set your Ethereum 1 node URL, e. g. use it with [Infura.io](https://infura.io/) and make it look like this: `eth1-endpoint: https://goerli.infura.io:443/v3/put-your-infura-id-here`.
