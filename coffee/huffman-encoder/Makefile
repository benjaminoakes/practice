.PHONY: spec build

build:
	mkdir -p build
	coffee --output build --compile lib/*.coffee

spec:
	jasmine-node --coffee spec/

doc:
	docco `find lib -name "*.coffee"` `find spec -name "*.coffee"`

clean:
	rm -rf public/build
	rm -rf docs
	rm -rf node_modules
