# Prysm standalone fullstack

## Requirements
* Get to know [Lodestar](https://chainsafe.github.io/lodestar/) a bit
* Server with 4 (v)cpus & 8 gb memory & 100 gb storage

## Services
* geth (beacon connects to it to see deposits for validators)
* beacon

**All services are enabled by default.**

## Validator accounts with launchpad
Please complete the steps on [launchpad](https://pyrmont.launchpad.ethereum.org/) and store the generated files of `~/eth2.0-deposit-cli/validator_keys` in `./launchpad/eth2.0-deposit-cli/validator_keys`.

1. Generate your validator(s) using [launchpad](https://pyrmont.launchpad.ethereum.org/) and complete the process
2. Copy your generated validator(s) from `~/eth2.0-deposit-cli/validator_keys` to `./launchpad/eth2.0-deposit-cli/validator_keys`
3. Run `docker-compose -f create-account.yaml run validator-import-launchpad` and use the **same password** as in the generation of the validator(s). Each validator must be provided password.

You can repeat step 2 & 3 as often as you like, make sure to restart your validator to make it notice your new accounts!

## Run your lodestar Ethereum 2.0 staking node

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
