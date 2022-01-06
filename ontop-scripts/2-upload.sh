#!/bin/bash

set -e
source .env

echo "$ENDPOINT"

curl -v \
     -X PUT \
     --header "Authorization: Basic $STARDOG_AUTH" \
     --header "Content-Type:application/n-triples; charset=utf-8" \
     -T ./triples-slug.nt \
     --data-urlencode graph=https://lod.lobbywatch.ch \
     -G $ENDPOINT
