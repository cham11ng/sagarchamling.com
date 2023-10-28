DESTDIR=public

.PHONY: theme-sync
theme-sync:
	@echo "Synchronizing theme. 🔄"
	rm -rf themes/*
	git submodule update --init --recursive
	git submodule update --remote --merge
	@echo "Completed. Ready to serve. ✅"

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

.PHONY: pretty
pretty:
	@echo "Making your site beautiful. 🧹"
	bunx prettier --write .
	@echo "Now, your site is pretty. ✨"
