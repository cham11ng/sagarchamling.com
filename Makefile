DESTDIR=public

.PHONY: clean
clean:
	@echo "Cleaning old build. 🧹"
	cd $(DESTDIR) && rm -rf *
	@echo "It is shining. ✨"

.PHONY: build
build:
	@echo "Generating site build. 🚧"
	hugo --gc --minify -d $(DESTDIR)
	@echo "Site built successfully. ✅"

.PHONE: pretty
pretty:
	@echo "Making your site beautiful. 🧹"
	bunx prettier --write .
	@echo "Now, your site is pretty. ✨"
