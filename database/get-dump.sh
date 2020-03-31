#!/bin/bash
wget https://cms.lobbywatch.ch/sites/lobbywatch.ch/files/exports/lobbywatch_export.sql.zip
unzip lobbywatch_export.sql.zip
rm lobbywatch_export.sql.zip
sed -i.bak 's@smallint(6) unsigned@int(6)@' lobbywatch.sql
