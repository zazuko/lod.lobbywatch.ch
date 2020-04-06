#!/bin/bash
BEFORE=$(wc -l lobbywatch.sql)
wget https://cms.lobbywatch.ch/sites/lobbywatch.ch/files/exports/lobbywatch_export.sql.zip
unzip lobbywatch_export.sql.zip
rm lobbywatch_export.sql.zip
AFTER=$(wc -l lobbywatch.sql)
echo "wc -l lobbywatch.sql BEFORE: $BEFORE"
echo "wc -l lobbywatch.sql AFTER:  $AFTER"
sed -i.bak 's@smallint(6) unsigned@int(6)@' lobbywatch.sql
