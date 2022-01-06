.PHONY: sql convert pipeline upload link

all: sql convert pipeline upload map link

sql:
	cd database && docker-compose stop db
	cd database && ./get-dump.sh
	cd database && docker-compose up -d db
	sleep 20
	mysql -h 127.0.0.1 -u root --database lobbywatch_public --password=public < database/wirksamkeit.sql

convert:
	cd ontop-scripts && ./1-convert.sh

pipeline:
	cd pipeline && npm install && npm run pipeline-file

upload:
	cd ontop-scripts && ./2-upload.sh

link:
	cd ontop-scripts && ./3-link.sh

transform:
	cd ontop-scripts && ./1-convert.sh
	cd pipeline && npm install && npm run pipeline-file
	cd ontop-scripts && ./2-upload.sh

map:
	cd ontop-scripts && ./4-sparql.sh
