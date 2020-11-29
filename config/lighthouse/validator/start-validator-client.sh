#! /bin/bash

DEFAULT_NETWORK=mainnet

# Set network name
if [ "$NETWORK" = "" ]; then
	NETWORK=$DEFAULT_NETWORK
fi

# Base dir
DATADIR=/root/.lighthouse/$NETWORK

WALLET_NAME=validators
WALLET_PASSFILE=$DATADIR/secrets/$WALLET_NAME.pass


if [ "$START_VALIDATOR" != "" ]; then
	if [ "$IMPORT_LAUNCHPAD_KEYSTORES" != "" ]; then
		echo $LAUNCHPAD_KEYSTORE_PASSWD | lighthouse \
			--network $NETWORK \
			account validator import \
			--directory /root/validator_keys \
			--reuse-password \
			--stdin-inputs
	else
		if [ ! -d $DATADIR ]; then
			mkdir $DATADIR
		fi

		if [ ! -d $DATADIR/secrets ]; then
			cd $DATADIR; mkdir secrets
		fi

		if [ ! -d $DATADIR/wallets ]; then
			lighthouse \
				--debug-level $DEBUG_LEVEL \
				--network $NETWORK \
				account \
				wallet \
				create \
				--name $WALLET_NAME \
				--password-file $WALLET_PASSFILE
		else
			echo "Wallet directory already exists. Will not create wallet."
		fi

		lighthouse \
			--debug-level $DEBUG_LEVEL \
			--network $NETWORK \
			account \
			validator \
			create \
			--wallet-name $WALLET_NAME \
			--wallet-password $WALLET_PASSFILE \
			--at-most $VALIDATOR_COUNT
	fi

	exec lighthouse \
		--debug-level $DEBUG_LEVEL \
		--network $NETWORK \
		validator \
		--beacon-node http://beacon:5052 \
		--init-slashing-protection
fi