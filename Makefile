.PHONY: sql load pipeline upload

all: sql load pipeline upload

sql:
	cd database && docker-compose down
	cd database && ./get-dump.sh
	cd database && docker-compose up -d && sleep 20

load:
	cd stardog-scripts && ./load.sh

pipeline:
	cd pipeline && npm run pipeline-file

upload:
	cd stardog-scripts && ./upload.sh
