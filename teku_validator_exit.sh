#!/usr/bin/expect -n

set timeout 20

set validator_key [lindex $argv 0];

spawn sudo docker exec -it stereum_beacon_1 /opt/teku/bin/teku voluntary-exit --beacon-node-api-endpoint=http://beacon:5051 --validator-keys=/launchpad/${validator_key}.json:/launchpad/${validator_key}.txt

expect "Are you sure you wish to continue\r"

set timeout 2

send -- "yes\n"

expect eof
