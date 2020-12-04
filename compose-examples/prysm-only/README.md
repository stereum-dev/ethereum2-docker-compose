# Prysm standalone fullstack

## Requirements
* Get to know [Prysm](https://docs.prylabs.network/docs/getting-started/) a bit
* Server with 4 (v)cpus & 8 gb memory & 100 gb storage

## Services
* geth (beacon conntects to it to see deposits for validators)
* beacon
* validator
* slasher
* prometheus
* grafana

**All services are enabled by default.**

### Minimal Setup (beacon & validator only)
In case you want to run only beacon & validator (geth, slasher, prometheus, grafana get disabled) move the `./compose-examples/prysm-only/override-examples/docker-compose.beacon-validator.override.yaml` file in the same folder as your `docker-compose.yaml` and rename it to `docker-compose.override.yaml`. Read up on [docker-compose files & override](https://docs.docker.com/compose/extends/#multiple-compose-files) to customize your setup further.

### ARM64 (raspberry pi)
Using this setup on a raspberry pi is as easy as copying the compose override file from `./compose-examples/prysm-only/override-examples/docker-compose.arm64.override.yaml` to `./docker-compose.override.yaml`. The override file should then be in the same folder as your `docker-compose.override.yaml`:
```
cp compose-examples/prysm-only/override-examples/docker-compose.arm64.override.yaml docker-compose.override.yaml
```
This also disables prometheus and grafana and uses external eth1 node connection (see `./config/prysm/beacon-no-geth.yaml` for changing the endpoint).

## (optional) Configure your node

### Public ip & other Prysm parameters/arguments
Configuration files are located in the folder `./config`. To gain a better connectivity for your beacon node you should specifiy your public ip and/or your dns name in `./config/prysm/beacon.yaml`. Follow the guide [Improve Peer-to-Peer Connectivity](https://docs.prylabs.network/docs/prysm-usage/p2p-host-ip/).

## Validator accounts with launchpad
Please complete the steps on [launchpad](https://pyrmont.launchpad.ethereum.org/) and store the generated files of `~/eth2.0-deposit-cli/validator_keys` in `./launchpad/eth2.0-deposit-cli/validator_keys`. The necessary directories need to be created. Please create the directories `./data/prysm/validator/wallets` and put your wallet password in `./data/prysm/validator/passwords/wallet-password`.

1. Generate your validator(s) using [launchpad](https://pyrmont.launchpad.ethereum.org/) and complete the process
2. Copy your generated validator(s) from `~/eth2.0-deposit-cli/validator_keys` to `./launchpad/eth2.0-deposit-cli/validator_keys`
3. Run `docker-compose -f create-account.yaml run validator-import-launchpad` and use the **same password** as in the generation of the validator(s)

You can repeat step 2 & 3 as often as you like, make sure to restart your validator to make it notice your new accounts!

## Run your prysm Ethereum 2.0 staking node

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

<<<<<<< HEAD
<<<<<<< HEAD
It's possible an error occures when starting up grafana:
```
grafana_1     | GF_PATHS_DATA='/var/lib/grafana' is not writable.
grafana_1     | You may have issues with file permissions, more information here: http://docs.grafana.org/installation/docker/#migration-from-a-previous-version-of-the-docker-container-to-5-1-or-later
grafana_1     | mkdir: can't create directory '/var/lib/grafana/plugins': Permission denied
```
Adding `user: <your-user-id>` to the service `grafana` in your `docker-compose.yaml` resolves this. Run `id -u` to get your user-id on linux.
=======
### Prysm Web Interface
Runs on http://localhost:7500, a wallet is already created then signup with your web interface password.

<<<<<<< HEAD
If not, use `Imported Wallet` option to import the your keystores & set your web interface password. 
>>>>>>> prysm web-ui
=======
If not, use `Imported Wallet` option to import your keystores & set your web interface password. 
>>>>>>> Update README.md
=======
### Prysm Web Interface
Runs on http://localhost:7500, a wallet is already created then signup with your web interface password.

If not, use `Imported Wallet` option to import your keystores & set your web interface password. 
>>>>>>> f411646cac104842fc57540ef9d88d049e66f77d

## FAQ
### I keep missing attestations or keep getting warnings/errors about `roughtime`
E. g. error messages like this:
```
WARN roughtime: Roughtime reports your clock is off by more than 2 seconds offset=4h0m0.345549475s
```
Make sure the OS' clock is synced. For Windows 10 and its subsystem linux might run on different times, to check this run `wsl` and then `date` (may differ by the OS you have installed).

Ask google on how to get your OS' time synced again.

### How do I install docker and docker-compose on raspberry pi?
There is an excellent short article about [how to install docker and docker-compose on raspberry pi](https://dev.to/rohansawant/installing-docker-and-docker-compose-on-the-raspberry-pi-in-5-simple-steps-3mgl), you can also use google to find another tutorial for it.

### I want to use a specific Ethereum 1 node!
<<<<<<< HEAD
<<<<<<< HEAD
Edit the line with `http-web3provider` in [./config/prysm/beacon.yaml](/config/prysm/beacon.yaml) and set your Ethereum 1 node URL, e. g. use it with [Infura.io](https://infura.io/) and make it look like this: `http-web3provider: "https://goerli.infura.io:443/v3/put-your-infura-id-here"` (make sure to use `""` for the url).
=======
Edit the line with `http-web3provider` in [./config/prysm/beacon.yaml](/config/prysm/beacon.yaml) and set your Ethereum 1 node URL, e. g. use it with [Infura.io](https://infura.io/) and make it look like this: `http-web3provider: https://goerli.infura.io:443/v3/put-your-infura-id-here`.
>>>>>>> prysm web-ui
=======
Edit the line with `http-web3provider` in [./config/prysm/beacon.yaml](/config/prysm/beacon.yaml) and set your Ethereum 1 node URL, e. g. use it with [Infura.io](https://infura.io/) and make it look like this: `http-web3provider: https://goerli.infura.io:443/v3/put-your-infura-id-here`.
>>>>>>> f411646cac104842fc57540ef9d88d049e66f77d
