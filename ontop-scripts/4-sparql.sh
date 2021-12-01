#!/bin/bash
set -e
source .env

#for query in "${QUERIES[@]}"
#do
#    echo $query
#    #curl \
#    #    --include -v \
#    #    --header "Authorization: Basic $STARDOG_AUTH" \
#    #    --header "Content-Type: application/sparql-update" \
#    #    --data-binary $query \
#    #    'http://data.zazuko.com/lobbywatch/update'
##
#
#    #curl -v -H "Accept: text/turtle" --header "Authorization: Basic $STARDOG_AUTH" --data-urlencode update@$query 'http://data.zazuko.com/lobbywatch/update/update'
#
#done

# Factions: order matters!
curl \
    --include -v \
    --header "Authorization: Basic $STARDOG_AUTH" \
    --header "Content-Type: application/sparql-update" \
    --data-binary '@queries/factions_auto_inwards.rq' \
    'http://data.zazuko.com/lobbywatch/update'

curl \
    --include -v \
    --header "Authorization: Basic $STARDOG_AUTH" \
    --header "Content-Type: application/sparql-update" \
    --data-binary '@queries/factions_auto_outwards.rq' \
    'http://data.zazuko.com/lobbywatch/update'


curl \
    --include -v \
    --header "Authorization: Basic $STARDOG_AUTH" \
    --header "Content-Type: application/sparql-update" \
    --data-binary '@queries/factions_manual.rq' \
    'http://data.zazuko.com/lobbywatch/update'

curl \
    --include -v \
    --header "Authorization: Basic $STARDOG_AUTH" \
    --header "Content-Type: application/sparql-update" \
    --data-binary '@queries/parliament.rq' \
    'http://data.zazuko.com/lobbywatch/update'

curl \
    --include -v \
    --header "Authorization: Basic $STARDOG_AUTH" \
    --header "Content-Type: application/sparql-update" \
    --data-binary '@queries/memberships.rq' \
    'http://data.zazuko.com/lobbywatch/update'
