#!/bin/bash
set -e
source .env

curl -v \
     -X PUT \
     --header "Authorization: Basic $STARDOG_AUTH" \
     --header "Content-Type:application/n-triples; charset=utf-8" \
     -T ./triples-slug.nt \
     -G http://data.zazuko.com/lobbywatch \
     --data-urlencode graph=https://lod.lobbywatch.ch
