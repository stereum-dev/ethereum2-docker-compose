#!/usr/bin/expect -f

set timeout -1
set validator_password [lindex $argv 0];

spawn docker-compose -f create-account.yaml run validator-import-launchpad

expect {
    "Please enter the password for decrypting" {
      send "$validator_password\r"
      sleep 5
      exp_continue
    }
    "The entered password was incorrect" exit
}
