#!/usr/bin/expect -n

set validator_pubkey [lindex $argv 0];

spawn sudo docker exec -it stereum_beacon_1 /opt/app/build/nimbus_beacon_node deposits exit --validator=$validator_pubkey --rpc-url=http://beacon:9190 --data-dir=/opt/app/validator --network=mainnet

expect "Your choice*\r"

send -- "I understand the implications of submitting a voluntary exit\n"

expect eof
