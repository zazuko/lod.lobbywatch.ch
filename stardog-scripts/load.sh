#!/bin/bash
IFS=$'\n\t'
set -euo pipefail

# delete DB and recreate
stardog-admin db drop -n lobbywatch || true
stardog-admin db create -n lobbywatch || true

# cache triples count (if any)
BEFORE=$(wc -l lobbywatch.nt)

# import SQL data using R2RML mapping as Virtual Graph
stardog-admin virtual import -v --format r2rml lobbywatch lobbywatch-mysql.properties ../mapping/src-gen/lobbywatch-mapping.r2rml.ttl

# export triple data as n-triples
curl --silent -G -u admin:admin -H  "Accept: application/n-triples" -o lobbywatch.nt http://localhost:5820/lobbywatch

# show triples count before/after
AFTER=$(wc -l lobbywatch.nt)
echo "wc -l lobbywatch.nt BEFORE: $BEFORE"
echo "wc -l lobbywatch.nt AFTER:  $AFTER"
