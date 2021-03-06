npmbin := ./node_modules/.bin
PORT ?= 3000
HOST ?= 127.0.0.1

help:
	@echo
	@echo Makefile targets
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' Makefile | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
	@echo

# Builds intermediate files. Needs a _site built first though
update: _site

# Builds _site
_site:
	yarn build

dev: 
	yarn dev

test: _site ## Runs rudimentary tests
	@test -f _site/vim.html
	@test -f _site/react.html
	@test -f _site/index.html
	@grep "<script src" _site/index.html >/dev/null
	@grep "<script src" _site/vim.html >/dev/null
	@grep "<script src" _site/react.html >/dev/null

test-warning:
	@echo "========="
	@echo "If your build failed at this point, it means"
	@echo "the site failed to generate. Check the project"
	@echo "out locally and try to find out why."
	@echo "========="
