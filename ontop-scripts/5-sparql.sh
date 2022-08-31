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
#    #    "${ENDPOINT}/update"
##
#
#    #curl -v -H "Accept: text/turtle" --header "Authorization: Basic $STARDOG_AUTH" --data-urlencode update@$query 'http://data.zazuko.com/lobbywatch/update/update'
#
#done

curl \
    --include -v \
    --header "Authorization: Basic $STARDOG_AUTH" \
    --header "Content-Type: application/sparql-update" \
    --data-binary '@queries/factions.rq' \
    "${ENDPOINT}/update"

curl \
    --include -v \
    --header "Authorization: Basic $STARDOG_AUTH" \
    --header "Content-Type: application/sparql-update" \
    --data-binary '@queries/parties.rq' \
    "${ENDPOINT}/update"

curl \
    --include -v \
    --header "Authorization: Basic $STARDOG_AUTH" \
    --header "Content-Type: application/sparql-update" \
    --data-binary '@queries/zefix.rq' \
    "${ENDPOINT}/update"

curl \
    --include -v \
    --header "Authorization: Basic $STARDOG_AUTH" \
    --header "Content-Type: application/sparql-update" \
    --data-binary '@queries/reverse_properties.rq' \
    "${ENDPOINT}/update"

curl \
    --include -v \
    --header "Authorization: Basic $STARDOG_AUTH" \
    --header "Content-Type: application/sparql-update" \
    --data-binary '@queries/legalforms.rq' \
    "${ENDPOINT}/update"
