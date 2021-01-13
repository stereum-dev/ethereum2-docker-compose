#! /bin/bash
#
# Starts a beacon node.

DEFAULT_NETWORK=pyrmont

if [ "$START_VALIDATOR" != "" ]; then
        ETH1_FLAG=--eth1
fi


if [ "$NETWORK" = "" ]; then
        NETWORK=$DEFAULT_NETWORK
fi

if [ "$ENABLE_METRICS" != "" ]; then
        METRICS_PARAMS="--metrics --metrics-address 0.0.0.0"
fi

if [ "$GRAFFITI" != "" ]; then
        GRAFFITI_PARAM="--graffiti $GRAFFITI"
fi

exec lighthouse \
        --debug-level $DEBUG_LEVEL \
        --network $NETWORK \
        beacon_node \
        --eth1-endpoints $VOTING_ETH1_NODE \
        --http \
        --http-address 0.0.0.0 \
        $METRICS_PARAMS \
        $GRAFFITI_PARAM \
        $ETH1_FLAG