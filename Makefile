DESTDIR=public

.PHONY: clean
clean:
	@echo "Cleaning old build"
	cd $(DESTDIR) && rm -rf *

.PHONY: build
build:
	@echo "Generating site build"
	hugo --gc --minify -d $(DESTDIR)
