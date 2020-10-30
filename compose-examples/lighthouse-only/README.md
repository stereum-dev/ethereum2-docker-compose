# Lighthouse standalone fullstack

## Requirements
* Get to know [Lighthouse](https://lighthouse-book.sigmaprime.io/) a bit
* Server with 4 (v)cpus & 8 gb memory & 100 gb storage

## Services
* geth (beacon conntects to it to see deposits for validators)
* beacon
* validator

**All services are enabled by default.**

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