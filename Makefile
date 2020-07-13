.PHONY: sql convert pipeline upload link

all: sql convert pipeline upload link

sql:
	cd database && docker-compose down
	cd database && ./get-dump.sh
	cd database && docker-compose up -d && sleep 20

convert:
	cd ontop-scripts && ./1-convert.sh

pipeline:
	cd pipeline && npm run pipeline-file

upload:
	cd ontop-scripts && ./2-upload.sh

link:
	cd ontop-scripts && ./3-link.sh
