curl --url http://localhost:8080/sparql \
     --header 'accept: application/n-triples' \
     --header 'content-type: application/sparql-query' \
     --data 'SELECT * WHERE { ?s ?p ?o . }'

