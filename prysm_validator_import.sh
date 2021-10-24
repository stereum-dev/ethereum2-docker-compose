#!/usr/bin/expect -f

set timeout -1
set validator_password [lindex $argv 0];

if {[ llength $validator_password ] == 0 } {
   exit
}

spawn sh -c { sudo docker exec -it stereum_validator_1 /app/cmd/validator/validator accounts import --keys-dir="/launchpad" --wallet-dir="/data/wallets" --wallet-password-file="/data/passwords/wallet-password" --accept-terms-of-use --prater }

expect {
    "Enter the password for your imported accounts" {
      send "$validator_password\r"
      sleep 5
      exp_continue
    }
    "Password incorrect for key" exit
}
