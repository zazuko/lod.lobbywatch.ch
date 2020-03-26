## Lobbywatch LOD Scripts

Scripts used to load the generated triples into a local [Stardog](https://www.stardog.com/) server and upload them to the hosted Stardog server used by [lod.lobbywatch.ch](https://lod.lobbywatch.ch).

* `./load.sh`

    Create triples using R2RML mapping, link against wikidata, dump as NTriple.

* `./upload.sh`

    Upload data to be used by <https://lod.lobbywatch.ch>.
