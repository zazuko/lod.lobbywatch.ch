import pandas as pd
from graphly.api_client import SparqlClient
from rdflib import Graph, URIRef

lobbywatchClient = SparqlClient("https://lod.lobbywatch.ch/query")
lindasClient = SparqlClient("https://lindas.admin.ch/query")


company_urls_lindas = lobbywatchClient.send_query(
    """
PREFIX schema: <http://schema.org/>

SELECT ?company_old ?uid
WHERE {
	?company_old a schema:Organization;
    <https://lod.lobbywatch.ch/inCommerceRegister> "true"^^xsd:boolean;
    schema:identifier ?uid.
}
"""
)
company_urls_zefix = lindasClient.send_query(
    """
PREFIX schema: <http://schema.org/>
SELECT ?company_new ?uid
WHERE {

    GRAPH <https://lindas.admin.ch/foj/zefix> {
    ?company_new a <https://schema.ld.admin.ch/ZefixOrganisation>;
       schema:identifier ?id.
    ?id schema:value ?uid;
       schema:name "CompanyUID".
    }
}
"""
)

inner_join = pd.merge(
    left=company_urls_lindas, right=company_urls_zefix, how="inner", on="uid"
)

g = Graph()
sameAs = URIRef("http://schema.org/sameAs")
for _, row in inner_join.iterrows():

    g.add(
        (
            URIRef(row["company_old"]),
            sameAs,
            URIRef(row["company_new"]),
        )
    )


g.serialize(destination="zefix.nt", format="nt", encoding="utf-8")
