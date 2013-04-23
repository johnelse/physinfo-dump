.PHONY: clean

dist/build/physinfo-dump/physinfo-dump:
	obuild configure
	obuild build

clean:
	rm -rf dist
