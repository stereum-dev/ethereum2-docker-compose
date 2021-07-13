#!/usr/bin/expect -f

set timeout -1
set validator_password [lindex $argv 0];

if {[ llength $validator_password ] == 0 } {
   exit
}

spawn docker-compose -f create-account.yaml run validator-import-launchpad

expect {
    "Enter the password for your imported accounts" {
      send "$validator_password\r"
      sleep 5
      exp_continue
    }
    "Password incorrect for key" exit
}
