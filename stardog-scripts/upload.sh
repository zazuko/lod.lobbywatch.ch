#!/bin/sh
curl -n -v \
     -X PUT \
     -H Content-Type:text/turtle \
     -T ./lobbywatch.ttl \
     -G http://data.zazuko.com/lobbywatch \
     --data-urlencode graph=https://lod.lobbywatch.ch
