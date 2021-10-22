#!/usr/bin/expect -f

set validator_pubkey [lindex $argv 0];

spawn sudo docker exec -it stereum_validator_1 /app/cmd/validator/validator accounts delete --wallet-dir=/data/wallets --wallet-password-file=/data/passwords/wallet-password --delete-public-keys=$validator_pubkey --accept-terms-of-use=true --prater

expect eof
