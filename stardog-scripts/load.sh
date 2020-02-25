#!/bin/bash
IFS=$'\n\t'
set -euo pipefail

stardog-admin db drop -n lobbywatch
stardog-admin db create -n lobbywatch || true
BEFORE=$(wc -l lobbywatch.ttl)
stardog-admin virtual import -v --format r2rml lobbywatch lobbywatch-mysql.properties ../r2rml-mapping/src-gen/lobbywatch-mapping.r2rml.ttl
curl --silent -G -u admin:admin -H  "Accept: text/turtle" -o lobbywatch.ttl http://localhost:5820/lobbywatch
AFTER=$(wc -l lobbywatch.ttl)

echo "wc -l lobbywatch.ttl BEFORE: $BEFORE"
echo "wc -l lobbywatch.ttl AFTER:  $AFTER"

# visual inspection of accented characters
grep "https://lod.lobbywatch.ch/parliament-member/2796> <https://schema.org/givenName" lobbywatch.ttl
