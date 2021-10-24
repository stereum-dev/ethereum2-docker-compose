#!/usr/bin/expect -f

set timeout -1
set validator_password [lindex $argv 0];

if {[ llength $validator_password ] == 0 } {
   exit
}

spawn sh -c {  sudo docker run --rm -it \
                -v "$(pwd)/wallets:/opt/app/validator" \
                -v "$(pwd)/launchpad:/opt/app/launchpad" \
                --entrypoint "/opt/app/start/import-launchpad-wallet.sh" validator_image
            }

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
