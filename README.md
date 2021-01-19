# Stereum.net's node setups

Run and monitor an Ethereum 2.0 staking node, choose your favorite client and start right away!

Visit us at [stereum.net](https://stereum.net/) for guides and on [Discord](https://discord.gg/8Znj8K6GjN) for support!

## Setups
Setup | Beacon | Staking | Monitoring
------|--------|---------|------------
[Lighthouse](./compose-examples/lighthouse-only) | ![yes](https://stereum.net/imgs/beacon.png) | ![yes](https://stereum.net/imgs/staking.png) | ![yes](https://stereum.net/imgs/monitoring.png)
[Lodestar](./compose-examples/lodestar-only) | ![yes](https://stereum.net/imgs/beacon.png) | - | ![yes](https://stereum.net/imgs/monitoring.png)
[Multiclient with Vouch & Dirk](./compose-examples/multiclient-vouch-dirk) | ![yes](https://stereum.net/imgs/beacon.png) | ![yes](https://stereum.net/imgs/staking.png) | ![yes](https://stereum.net/imgs/monitoring.png)
[Nimbus Eth2](./compose-examples/nimbus-only) | ![yes](https://stereum.net/imgs/beacon.png) | ![yes](https://stereum.net/imgs/staking.png) | ![yes](https://stereum.net/imgs/monitoring.png)
[Prysm](./compose-examples/prysm-only) | ![yes](https://stereum.net/imgs/beacon.png) | ![yes](https://stereum.net/imgs/staking.png) | ![yes](https://stereum.net/imgs/monitoring.png)
[Teku](./compose-examples/teku-only) | ![yes](https://stereum.net/imgs/beacon.png) | ![yes](https://stereum.net/imgs/staking.png) | ![yes](https://stereum.net/imgs/monitoring.png)

<sub><sup>Sorted by name (ascending).</sup></sub>

## Testnet or Mainnet
**You are viewing this repository with configuration for testnet (Pyrmont)**

Default is Pyrmont, the long-term testnet for Ethereum 2.0. For running on Mainnet, checkout `mainnet` branch by executing the following commands after `git clone`:
```
git checkout mainnet
```
Not all setups are available for Mainnet yet.

## Run a node
1. Select a docker-compose from the list above.
2. Copy the `docker-compose.yaml` of your choice to the project's root directory (this directory).
3. Follow the guide included with the docker-compose (`README.md` of the selected docker-compose).

### User id 2000
Some components like grafana and nimbus need folders with special permission and/or owner. To make the setup of ethereum2-docker-compose as simple as possible these necessary permissions will be set on each startup with the user id of 2000.

It's possible (however highly unlikely) that your local system already has a user with the id of 2000. In this case the folders will show the name of your user. We recommend not using a local user with the id 2000 for security reasons.

## FAQ
### My `docker-compose` command doesn't work (e. g. `ERROR: Version in "./docker-compose.yaml" is unsupported.`)
Most linux distributions (including Ubuntu) don't serve recent docker-compose versions in their package management. You can install a compatible version by following [official docker.io documentation](https://docs.docker.com/compose/install/).

## Support us!
This software is provided under MIT license and therefore freely usable without restrictions. Dontations are welcome at [gitcoin.co](https://gitcoin.co/grants/1855/stereumnet) to make use of quadratic funding and make your contribution count even more! With your donation you help us build new features and keep our servers for testnet running. Thank you for every contribution!
