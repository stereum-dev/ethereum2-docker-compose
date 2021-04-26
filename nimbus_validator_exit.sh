#!/usr/bin/expect -n

set validator_pubkey [lindex $argv 0];

spawn sudo PUBKEY="$validator_pubkey" docker-compose -f exit-account.yaml run exit-validator

expect "Your choice*\r"

send -- "I understand the implications of submitting a voluntary exit\n"

expect eof
