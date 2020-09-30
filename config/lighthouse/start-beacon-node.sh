#! /bin/bash
#
# Starts a beacon node.

DEFAULT_TESTNET=medalla

if [ "$START_VALIDATOR" != "" ]; then
	ETH1_FLAG=--eth1
fi


if [ "$TESTNET" = "" ]; then
	TESTNET=$DEFAULT_TESTNET
fi


DATADIR=/root/.lighthouse/$TESTNET

if [ "$GRAFFITI" != "" ]; then
	GRAFFITI_PARAM="--graffiti $GRAFFITI"
fi

exec lighthouse \
	--debug-level $DEBUG_LEVEL \
	--testnet $TESTNET \
	--datadir $DATADIR \
	beacon_node \
	--eth1-endpoint $VOTING_ETH1_NODE \
	--http \
	--http-address 0.0.0.0 \
	--ws \
	--ws-address 0.0.0.0 \
	--max-skip-slots 700 \
	$GRAFFITI_PARAM \
	$ETH1_FLAG