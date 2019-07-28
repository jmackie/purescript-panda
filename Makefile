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

.PHONY: clean
clean:
	rm -rf .spago output
	rm -rf examples/{.spago,output,node_modules,dist}
