#! /bin/bash
#
# Starts a beacon node.

DEFAULT_TESTNET=pyrmont

if [ "$START_VALIDATOR" != "" ]; then
        ETH1_FLAG=--eth1
fi


if [ "$TESTNET" = "" ]; then
        TESTNET=$DEFAULT_TESTNET
fi

if [ "$ENABLE_METRICS" != "" ]; then
        METRICS_PARAMS="--metrics --metrics-address 0.0.0.0"
fi

if [ "$GRAFFITI" != "" ]; then
        GRAFFITI_PARAM="--graffiti $GRAFFITI"
fi

exec lighthouse \
        --debug-level $DEBUG_LEVEL \
        --testnet $TESTNET \
        beacon_node \
        --eth1-endpoint $VOTING_ETH1_NODE \
        --http \
        --http-address 0.0.0.0 \
        $METRICS_PARAMS \
        --ws \
        --ws-address 0.0.0.0 \
        --max-skip-slots 700 \
        $GRAFFITI_PARAM \
        $ETH1_FLAG