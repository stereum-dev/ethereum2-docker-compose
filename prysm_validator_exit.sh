#!/usr/bin/expect -n

set validator_pubkey [lindex $argv 0];

spawn sudo PUBKEY="$validator_pubkey" docker-compose -f exit-account.yaml run exit-validator

expect "If you still want to continue with the voluntary exit*\r"

send -- "Exit my validator\n"

expect eof
