#!/bin/bash

# link parliament members to wikidata
curl -n \
--data timeout=1000000 \
--data-urlencode update='
  INSERT {
    GRAPH <https://lod.lobbywatch.ch> {
      ?lwPerson <http://schema.org/sameAs> ?wikidataPerson .
    }
  }
  WHERE {
    ?lwPerson a <http://dbpedia.org/ontology/MemberOfParliament> ;
              <http://www.wikidata.org/prop/direct/P1307> ?parliamentId .
    BIND (STR(?parliamentId) AS ?pid)

    SERVICE <https://query.wikidata.org/sparql> {
      ?wikidataPerson <http://www.wikidata.org/prop/direct/P1307> ?pid .
    }
  }
  ' \
  http://data.zazuko.com/lobbywatch/update
