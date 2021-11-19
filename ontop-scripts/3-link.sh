#!/bin/bash
set -e
source .env

# link against external sources

curl \
    --include -v \
    --header "Authorization: Basic $STARDOG_AUTH" \
    --header "Content-Type: application/sparql-update" \
    --data-binary '@queries/wikidata-parliament-member.rq' \
    'http://data.zazuko.com/lobbywatch/update'

curl \
    --include -v \
    --header "Authorization: Basic $STARDOG_AUTH" \
    --header "Content-Type: application/sparql-update" \
    --data-binary "@queries/wikidata-party.rq" \
    'http://data.zazuko.com/lobbywatch/update'
