## CSS
CSS_SRC_FOLDER := sources/stylesheets
CSS_OUT_FOLDER := stylesheets
CSS_ENTRIES := main
SASS_FLAGS := -I node_modules/ --no-source-map

## JS
JS_SRC_FOLDER := sources/javascripts
JS_OUT_FOLDER := javascripts
JS_ENTRIES := application editmode
ROLLUP_FLAGS := --format=umd -p @rollup/plugin-node-resolve

## IMAGES
IMAGES_MINIFY_SRC_FOLDER := sources/images/minify
IMAGES_COPY_SRC_FOLDER := sources/images/copy
IMAGES_OUT_FOLDER := images

## Tasks
.DEFAULT_GOAL := help
.PHONY: help

help:
	@echo 'Available commands:'
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

## Install NPM dependencies
install:
	@echo "Installing Node dependencies"
	@npm install

build-css:
	@echo "Building CSS"
	$(foreach entry,$(CSS_ENTRIES),npx sass $(SASS_FLAGS) $(CSS_SRC_FOLDER)/$(entry).scss:$(CSS_OUT_FOLDER)/$(entry).css;)

minify-css:
	@echo "Minifying CSS"
	$(foreach entry,$(CSS_ENTRIES),npx sass $(SASS_FLAGS) --style=compressed $(CSS_OUT_FOLDER)/$(entry).css:$(CSS_OUT_FOLDER)/$(entry).min.css;)

## Build and minify CSS
css: build-css minify-css

## Watch CSS source files and rebuild if necessary
watch-css:
	@echo "Watching CSS source files"
	npx chokidar $(CSS_SRC_FOLDER)/* -c "make build-css && make minify-css"

build-js:
	@echo "Building JS"
	$(foreach entry,$(JS_ENTRIES),npx rollup $(ROLLUP_FLAGS) --file=$(JS_OUT_FOLDER)/$(entry).js -- $(JS_SRC_FOLDER)/$(entry).js;)

minify-js:
	@echo "Minifying JS"
	$(foreach entry,$(JS_ENTRIES),npx rollup $(ROLLUP_FLAGS) -p @rollup/plugin-terser --file=$(JS_OUT_FOLDER)/$(entry).min.js -- $(JS_SRC_FOLDER)/$(entry).js;)

## Build and minify JS
js:
	@make build-js & make minify-js

## Watch JS source files and rebuild if necessary
watch-js:
	@echo "Watching JS source files"
	npx chokidar $(JS_SRC_FOLDER)/* -c "make js"

## Minifiy images
process-images:
	@echo "Processing images"
	npx imagemin $(IMAGES_MINIFY_SRC_FOLDER)/* --out-dir=$(IMAGES_OUT_FOLDER)
	@cp -a $(IMAGES_COPY_SRC_FOLDER)/. $(IMAGES_OUT_FOLDER)

## Run dev workflow
dev:
	@echo "Running dev workflow"
	@make watch-css & make watch-js & make process-images

## Run dev workflow with kit
dev-kit:
	@echo "Running dev workflow with kit"
	@make watch-css & make watch-js & make process-images & kit watch

## Build for production
prod:
	@echo "Running production build"
	@make css & make js & make process-images
