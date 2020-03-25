.PHONY: load pipeline upload wd

all: load pipeline upload

load:
	cd stardog-scripts && ./load.sh

pipeline:
	cd pipeline && npm run pipeline-file

upload:
	cd stardog-scripts && ./upload.sh

wd:
	cd stardog-scripts && ./wd.sh