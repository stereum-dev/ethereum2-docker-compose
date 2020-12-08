#!/bin/bash

echo "-- git stash -- save current changes to this repository"
git stash

echo "-- git pull -- pull in changes of origin"
git pull

echo "-- git stash pop -- apply saved changes to the changes of update"
git stash pop

echo "---------------"
echo "Please review conflicts before restarting any services!"

