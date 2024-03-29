#!/bin/bash

set -e
source .env

curl -v \
     -X PUT \
     --header "Authorization: Basic $STARDOG_AUTH" \
     --header "Content-Type:application/n-triples; charset=utf-8" \
     -T ./triples-slug.nt \
     --data-urlencode graph=https://lod.lobbywatch.ch \
     -G $ENDPOINT

curl -v \
     -X POST \
     --header "Authorization: Basic $STARDOG_AUTH" \
     --header "Content-Type:text/turtle" \
     -T ./metadata.ttl \
     --data-urlencode graph=https://lod.lobbywatch.ch \
     -G $ENDPOINT
