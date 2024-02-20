.PHONY: setup upgrade clean build pretty compress sync help
.DEFAULT_GOAL := help

define BROWSER_PYSCRIPT
import webbrowser, sys

webbrowser.open(sys.argv[1])
endef
export BROWSER_PYSCRIPT

DESTDIR=public
BROWSER := python3 -c "$$BROWSER_PYSCRIPT"

define PRINT_HELP_PYSCRIPT
import re, sys

for line in sys.stdin:
	match = re.match(r'^([a-zA-Z_-]+):.*?## (.*)$$', line)
	if match:
		target, help = match.groups()
		print("%-20s %s" % (target, help))
endef
export PRINT_HELP_PYSCRIPT

setup: ## Setup site development mode.
	@bun install
	@git submodule update --init --recursive
	@echo "Completed. Ready to serve. ✅"

upgrade: ## Upgrade bun packages.
	@bun update
	@echo "Completed. ✅"

clean: ## Clean old builds.
	@echo "Cleaning old build. 🧹"
	@if [ -d "$(DESTDIR)" ]; then \
		cd $(DESTDIR) && rm -rf *; \
		echo "It is shining. ✨"; \
	else \
		echo "Its already shining. ✨"; \
	fi

build: ## Build minified version of site.
	@echo "Generating site build. 🚧"
	@hugo --gc --minify -d $(DESTDIR)
	@echo "Site built successfully. ✅"

pretty: ## Format site using prettier.
	@echo "Making your site beautiful. 🧹"
	@bunx prettier --write .
	@echo "Now, your site is pretty. ✨"

compress: ## Compress all .png files into .webp format.
	@python3 cwebp.py

sync: ## Synchronize with the latest theme.
	@echo "Synchronizing theme. 🔄"
	@rm -rf themes/*
	@git submodule update --init --recursive
	@git submodule update --remote --merge
	@echo "Completed. Ready to serve. ✅"

help: ## Help using make file.
	@python3 -c "$$PRINT_HELP_PYSCRIPT" < $(MAKEFILE_LIST)
