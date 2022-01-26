.PHONY: sql convert pipeline zefix link

all: sql convert convert pipeline zefix link map

sql:
	cd database && docker-compose stop db
	cd database && ./get-dump.sh
	cd database && docker-compose up -d db
	sleep 20
	wget -O database/wirksamkeit.sql https://raw.githubusercontent.com/lobbywatch/lobbywatch/master/public_db_views.sql
	ls database
	mysql -h 127.0.0.1 -u root --database lobbywatch_public --password=public < database/wirksamkeit.sql

convert:
	cd ontop-scripts && ./1-convert.sh

pipeline:
	wc -l ontop-scripts/triples.nt
	cd pipeline && npm install && npm run pipeline-file
	cd ontop-scripts && ./2-upload-all.sh
	wc -l ontop-scripts/triples-slug.nt

zefix:
	cd ontop-scripts && python zefix.py
	cd ontop-scripts && ./3-upload-zefix.sh

link:
	cd ontop-scripts && ./4-link.sh

map:
	cd ontop-scripts && ./5-sparql.sh
