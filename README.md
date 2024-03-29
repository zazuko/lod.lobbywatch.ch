# Lobbywatch Linked Open Data

This project contains the source and tooling related to [lod.lobbywatch.ch](https://lod.lobbywatch.ch), the linked open data platform hosting the [lobbywatch.ch](https://lobbywatch.ch) data.

## Repository Structure

* [`Makefile`](./Makefile)

    `make` runs all targets: converting the MySQL db into triples, enriching the triples, running them through the pipeline, uploading to lod.lobbywatch.ch

* [`database/`](./database/)

    Retrieving a SQL dump of the lobbywatch database and serving it locally.

* [`lod.lobbywatch.ch/`](./lod.lobbywatch.ch/)

    [lod.lobbywatch.ch](https://lod.lobbywatch.ch) source code and deployment setup.

* [`mapping/`](./mapping/)

    [R2RML](https://www.w3.org/TR/r2rml/#abstract) mappings used to convert the MySQL database content into triples. The R2RML mappings are generated using the [RDF Mapping DSL](https://github.com/zazuko/rdf-mapping-dsl-user).

* [`pipeline/`](./pipeline/)

    Pipeline used to slugify some IRIs.

* [`ontop-scripts/`](./ontop-scripts/)

    Scripts used to install Ontop, to generate triples from MySQL to n-triples server, transform them, upload them to the hosted Stardog server used by [lod.lobbywatch.ch](https://lod.lobbywatch.ch) and link them.

## Deployment

Pushing a new version triggers a CI build and deploys the version on success:

1. `cd lod.lobbywatch.ch`
2. `npm version <major|minor|patch>`
3. `git add .`
4. `git commit -m your-message`
5. `git tag -a vYourNpmVrsion`
6. `git push --follow-tags`
