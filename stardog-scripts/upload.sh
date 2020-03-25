#!/bin/sh
curl -n -v \
     -X PUT \
     -H "Content-Type:application/n-triples; charset=utf-8" \
     -T ./lobbywatch-slug.nt \
     -G http://data.zazuko.com/lobbywatch \
     --data-urlencode graph=https://lod.lobbywatch.ch
