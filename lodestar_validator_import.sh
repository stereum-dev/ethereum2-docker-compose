#!/usr/bin/expect -f

set timeout -1
set validator_password [lindex $argv 0];

if {[ llength $validator_password ] == 0 } {
   exit
}

spawn docker-compose -f create-account.yaml run validator-import-launchpad

sleep 5
expect {
    "*Invalid password*" exit
    "Password is correct" {
        sleep 5
        exp_continue
    } "All validators are already imported" exit
      "Enter the keystore password, or press enter to omit it" {
        send "$validator_password\r"
        sleep 5
        exp_continue
      }
}
