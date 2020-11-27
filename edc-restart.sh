#!/bin/sh

docker-compose stop $* && docker-compose --compatibility up -d $*