# Nimbus standalone fullstack

## Requirements
* Get to know [Nimbus Eth2](https://nimbus.team/docs/eth2.html) a bit
* Server with 4 (v)cpus & 8 gb memory & 100 gb storage

## Services
* geth (beacon conntects to it to see deposits of validators)
* beacon

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
