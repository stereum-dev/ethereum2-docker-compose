#!/usr/bin/expect -f

set timeout -1
set validator_password [lindex $argv 0];

spawn docker-compose -f create-account.yaml run validator-import-launchpad

expect {
    "Enter the keystore password" {
      send "$validator_password\r"
      sleep 3
      set results $expect_out(buffer)
      if {[regexp -nocase "Invalid password" $results]} {
        exit
      } elseif {[regexp -nocase "Skipping import of keystore for existing public key" $results]} {
        exit
      }
      exp_continue
    }
}
