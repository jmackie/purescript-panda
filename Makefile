.PHONY: all
all: build test

.PHONY: build
build:
	spago build -- --codegen js,docs

.PHONY: test
test: build examples

.PHONY: examples
examples:
	cd examples && yarn install && yarn build

.PHONY: format
format:
	git ls-files | grep -E '*.purs$$' | xargs -I {} purty {} --write
	git ls-files | grep -E '*.dhall$$' | xargs -I {} dhall --ascii format --inplace {}

.PHONY: clean
clean:
	rm -rf .spago output
	rm -rf examples/{.spago,output,node_modules,dist}
