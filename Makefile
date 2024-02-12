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
	if [ -d "$(DESTDIR)" ]; then \
		cd $(DESTDIR) && rm -rf *; \
		echo "It is shining. ✨"; \
	else \
		echo "Its already shining. ✨"; \
	fi

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
