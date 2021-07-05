#!/usr/bin/expect -n

set timeout 20

set validator_key [lindex $argv 0];

spawn sudo KEY="$validator_key" docker-compose -f exit-account.yaml run exit-validator

expect "Are you sure you wish to continue\r"

set timeout 2

send -- "yes\n"

expect eof
