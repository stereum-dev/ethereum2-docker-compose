# ethereum2-docker-compose

Run and monitor an Ethereum 2.0 staking node. Provides multiple `docker-compose.yaml` for different scenarios.

docker-compose | Description
---------------|-------------
[Multiclient with Vouch & Dirk](./compose-examples/multiclient-vouch-dirk) | Using multiple beacons ([Prysm](https://github.com/prysmaticlabs/prysm), [Lighthouse](https://github.com/sigp/lighthouse), [Teku](https://github.com/ConsenSys/teku)) and [Vouch](https://github.com/attestantio/vouch) with [Dirk](https://github.com/attestantio/dirk) and monitoring
[Prysm standalone](./compose-examples/prysm-only) | Stand-alone [Prysm](https://github.com/prysmaticlabs/prysm) fullstack node and monitoring
[Lighthouse standalone](./compose-examples/lighthouse-only) | Stand-alone [Lighthouse](https://github.com/sigp/lighthouse) node and monitoring

## Testnet (Pyrmont) or Mainnet
**You are viewing this repository with configuration for Mainnet**

Default is Pyrmont, the long-term testnet for Ethereum 2.0. For running on Mainnet, checkout `mainnet` branch by executing the following commands after `git clone`:
```
git checkout mainnet
```

### Links
Service | Pyrmont (Testnet) | Mainnet
--------|-------------------|---------
Block explorer | https://beaconscan.com/pyrmont or https://pyrmont.beaconcha.in/ | https://beaconscan.com/ or https://beaconcha.in/
Ethereum Launchpad | https://pyrmont.launchpad.ethereum.org/ | https://launchpad.ethereum.org/

## Run a node
1. Select a docker-compose from the list above.
2. Copy the `docker-compose.yaml` of your choice to the project's root directory (this directory).
3. Follow the guide included with the docker-compose (`README.md` of the selected docker-compose).

## FAQ
### My `docker-compose` command doesn't work (e. g. `ERROR: Version in "./docker-compose.yaml" is unsupported.`)
Most linux distributions (including Ubuntu) don't serve recent docker-compose versions in their package management. You can install a compatible version by following [official docker.io documentation](https://docs.docker.com/compose/install/).

## Support the maintainer
This software is provided under MIT license and therefore freely usable without restrictions. Dontations are always welcome:

ETH - 0xA1DDc7ed6E7b9179C68cDEE24a5e47dE930061eE

BTC - 39n4LUxbcCfJvBGvFVVwQQkGxSJ44JRYV7
