#!/bin/bash
IFS=$'\n\t'
set -euo pipefail

# delete DB and recreate
stardog-admin db drop -n lobbywatch
stardog-admin db create -n lobbywatch || true

# cache triples count (if any)
BEFORE=$(wc -l lobbywatch.ttl)

# import SQL data using R2RML mapping as Virtual Graph
stardog-admin virtual import -v --format r2rml lobbywatch lobbywatch-mysql.properties ../mapping/src-gen/lobbywatch-mapping.r2rml.ttl

# export triple data as Turtle
curl --silent -G -u admin:admin -H  "Accept: text/turtle" -o lobbywatch.ttl http://localhost:5820/lobbywatch

# show triples count before/after
AFTER=$(wc -l lobbywatch.ttl)
echo "wc -l lobbywatch.ttl BEFORE: $BEFORE"
echo "wc -l lobbywatch.ttl AFTER:  $AFTER"

# visual inspection of accented characters
grep "https://lod.lobbywatch.ch/parliament-member/2796> <https://schema.org/givenName" lobbywatch.ttl
