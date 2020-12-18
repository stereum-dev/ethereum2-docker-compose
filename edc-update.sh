#!/bin/bash

v_mode=none

v_compose_yaml_origin=none
if  ( grep -Fxq "  prysm_beacon:" docker-compose.yaml  &&
      grep -Fxq "  lighthouse_beacon:" docker-compose.yaml  &&
      grep -Fxq "  teku_beacon:" docker-compose.yaml ); then
  echo "Found multiclient setup"
  v_mode=mc
  v_compose_yaml_origin="compose-examples/multiclient-vouch-dirk/docker-compose.yaml"

elif ( grep -Fxq "  validator:" docker-compose.yaml &&
       grep -Fxq "  beacon:" docker-compose.yaml ); then

  if ( grep -Eq "^\s{4,}image: sigp\/lighthouse:" docker-compose.yaml ); then
    echo "Found lighthouse setup"
        v_mode=l
        v_compose_yaml_origin="compose-examples/lighthouse-only/docker-compose.yaml"

  elif ( grep -Eq "^\s{4,}image: gcr\.io\/prysmaticlabs\/prysm\/validator" docker-compose.yaml ); then
    echo "Found prysm setup"
        v_mode=p
        v_compose_yaml_origin="compose-examples/prysm-only/docker-compose.yaml"

  elif ( grep -Eq "^\s{4,}image: pegasyseng\/teku" docker-compose.yaml ); then
    echo "Found teku setup"
        v_mode=t
        v_compose_yaml_origin="compose-examples/teku-only/docker-compose.yaml"

  else
    echo "Couldn't identify setup!"
    exit 1
  fi;
fi;

echo ""

v_compose_yaml_checksum=$(sha256sum $v_compose_yaml_origin | cut -d' ' -f1)

echo "-- git stash -- save current changes to this repository"
git stash -q

echo "-- git pull -- pull in changes of origin"
git pull -q

echo "-- git stash pop -- apply saved changes to the changes of update"
git stash pop -q

echo ""

v_git_conflicts=$(git diff --name-only --diff-filter=U)

if [ ${#v_git_conflicts} -gt 1 ]; then
  echo "Conflicts (please edit the files before restarting any services):"
  echo "$v_git_conflicts"
  echo ""
fi

v_compose_yaml_new_checksum=$(sha256sum $v_compose_yaml_origin | cut -d' ' -f1)

if [ "$v_compose_yaml_checksum" != "$v_compose_yaml_new_checksum" ]; then
  echo "Important: $v_compose_yaml_origin was updated! Make sure to copy the new docker-compose.yaml to the project's root."
fi