#!/usr/bin/expect -n

set validator_pubkey [lindex $argv 0];

spawn sudo PUBKEY="$validator_pubkey" docker-compose -f delete-account.yaml run validator-delete-accounts

expect eof
