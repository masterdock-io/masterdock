#!/bin/sh

print_usage () {
  echo "Usage: create-network.sh [name] [subnet-string] [gateway-string]" 1>&2
  echo "   ex) $ ./create-network.sh vpcbr 172.16.0.0/24 172.16.0.1" 1>&2
  exit 1
}

if [ $# -ne 3 ]; then
  print_usage
else
  NAME=$1
  SUBNET=$2
  GATEWAY=$3
fi

echo "Start creating network "$SUBNET" on docker env [GATEWAY:"$GATEWAY"]."

docker network create \
  --driver=bridge \
  --subnet=$SUBNET \
  --gateway=$GATEWAY \
  $NAME

echo "End creating network on docker env."
