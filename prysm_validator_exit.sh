#!/usr/bin/expect -n

set validator_pubkey [lindex $argv 0];

spawn sudo docker exec -it stereum_validator_1 /app/cmd/validator/validator accounts voluntary-exit --wallet-dir=/data/wallets --wallet-password-file=/data/passwords/wallet-password --public-keys=$validator_pubkey --accept-terms-of-use=true --beacon-rpc-provider=beacon:4000 --prater

expect "If you still want to continue with the voluntary exit*\r"

send -- "Exit my validator\n"

expect eof
