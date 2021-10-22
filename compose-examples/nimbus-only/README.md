# Nimbus node

## Requirements
* Get to know [Nimbus Eth2](https://nimbus.team/docs/eth2.html) a bit
* Server with 4 (v)cpus & 8 gb memory & 250 gb storage

## Services
* [geth](https://github.com/ethereum/go-ethereum)
* beacon (including validator)
* prometheus
* grafana

**All services are enabled by default.**

## (optional) Configure your node

### Public ip for better connectivity
In `docker-compose.yaml` you can add a new line to `command: ` under the beacon service with the following content to make your public ip known to the service:
```
...
  beacon:
    ...
    command:
    ...
      - --nat=extip:1.2.3.4
```
Replace `1.2.3.4` with your public ip address.

## Validator accounts with launchpad
Please complete the steps on [launchpad](https://launchpad.ethereum.org/)

1. Generate your validator(s) using [launchpad](https://launchpad.ethereum.org/) and complete the process
2. Copy your generated validator(s) from `~/eth2.0-deposit-cli/validator_keys` to `./launchpad`
3. Run `./nimbus_validator_import.sh <ValidatorPassword>` Put your validator password instead `<ValidatorPassword>`
4. Run `docker-compose stop validator` then `docker-compose up -d validator` to restart validator service

For instance: `./prysm_validator_exit.sh MyPassword`

The "Expect" needs to be installed to execute `nimbus_validator_import.sh`. Run `apt-get install expect` to install expect on Ubuntu

## Validator accounts voluntary exit
The Beacon node needs to be fully synced to implement voluntary exit of validator!

1. Run `./nimbus_validator_exit.sh <ValidatorPublicKey>` Put your validator public key instead `<ValidatorPublicKey>`
2. Run `docker-compose stop validator` then `docker-compose up -d validator` to restart validator service

For instance: `./nimbus_validator_exit.sh 0xabcde12345...`

The "Expect" needs to be installed to execute `nimbus_validator_exit.sh`. Run `apt-get install expect` to install expect

## Run your Nimbus Ethereum 2.0 beacon node

### Start it up
Run with (as deamon with "-d")
```
docker-compose up -d
```
or run only certain services (in this case beacon only)
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
Runs on http://localhost:9098, scrapes data of beacon and validator.

### Grafana
Grafana listens on http://localhost:3008 and uses the data provided by prometheus service.

Login with username `admin` and password `admin` (Grafana defaults), data source to Prometheus is already established and dashboards installed.

## FAQ
### I want to use a specific Ethereum 1 node, like Infura.io!
1. Edit `./compose-examples/nimbus-only/docker-compose.yaml` and go to the service`beacon:` then set `--web3-url=` to your external Ethereum 1 node, e. g. `--web3-url=wss://goerli.infura.io/ws/v3/put-your-infura-id-here`.
2. Copy `./compose-examples/nimbus-only/override-examples/docker-compose.no-geth.override.yaml` to `./docker-compose.override.yaml`. This will disable geth for your node.
