#!/bin/bash

if [[ $EUID -ne 0 ]]; then
  clear
  echo "This script must be run as root."
  exit 1
fi

docker stop dirk
docker cp dirk:/config/storage data/attestant/dirk/protection
