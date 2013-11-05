
all: debug

debug:
	openfl build linux -debug

release:
	openfl build linux

flash:
	openfl build flash

flash-test:
	openfl test flash

test:
	openfl test linux -debug

clean:
	openfl clean linux

.PHONY: all debug test release
