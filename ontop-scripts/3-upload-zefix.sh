#!/bin/bash

set -e
source .env

curl -v \
     -X POST \
     --header "Authorization: Basic $STARDOG_AUTH" \
     --header "Content-Type:application/n-triples; charset=utf-8" \
     -T ./zefix.nt \
     --data-urlencode graph=https://lod.lobbywatch.ch \
     -G $ENDPOINT
