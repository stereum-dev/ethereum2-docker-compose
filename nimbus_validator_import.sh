#!/usr/bin/expect -f

set timeout -1
set validator_password [lindex $argv 0];

if {[ llength $validator_password ] == 0 } {
   exit
}

spawn sh -c { sudo docker exec -it stereum_beacon_1 /opt/app/build/nimbus_beacon_node deposits import "/opt/app/validator_keys" --data-dir="/opt/app/validator" --network="prater" }

expect {
    "Please enter the password for decrypting" {
      send "$validator_password\r"
      sleep 5
      exp_continue
    }
    "The entered password was incorrect" exit
}
