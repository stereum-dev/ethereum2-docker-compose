#!/usr/bin/expect -n

set validator_pubkey [lindex $argv 0];

spawn sudo PUBKEY="$validator_pubkey" docker-compose -f exit-account.yaml run exit-validator

expect "BE UNTIL AT LEAST TWO YEARS AFTER THE PHASE\r"

send -- "\033\[B\r"

expect eof
