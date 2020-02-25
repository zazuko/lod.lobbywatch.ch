# Lobbywatch Linked Open Data

This project contains the source and tooling related to [lod.lobbywatch.ch](https://lod.lobbywatch.ch), the linked open data platform hosting the [lobbywatch.ch](https://lobbywatch.ch) data.

## Repository Structure

* [`database/`](./database/)

    Retrieving a SQL dump of the lobbywatch database and serving it locally.

* [`lod.lobbywatch.ch/`](./lod.lobbywatch.ch/)

    [lod.lobbywatch.ch](https://lod.lobbywatch.ch) source code and deployment setup.

* [`mapping/`](./mapping/)

    [R2RML](https://www.w3.org/TR/r2rml/#abstract) mappings used to convert the MySQL database content into triples. The R2RML mappings are generated using the [RDF Mapping DSL](https://github.com/zazuko/rdf-mapping-dsl-user).

* [`stardog-scripts/`](./stardog-scripts/)

    Scripts used to load the generated triples into a local [Stardog](https://www.stardog.com/) server and upload them to the hosted Stardog server used by [lod.lobbywatch.ch](https://lod.lobbywatch.ch).

## Deployment

Pushing a new version triggers a CI build and deploys the version on success:

1. `cd lod.lobbywatch.ch`
1. `npm version <major|minor|patch>`
1. `git push --follow-tags`
