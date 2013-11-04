
all: debug

debug:
	openfl build linux -debug

release:
	openfl build linux

test: debug
	openfl test linux -debug

clean:
	openfl clean linux

.PHONY: all debug test release
