
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

upload: flash
	scp index.html Gourdgeous.swf bytten.net:/home/tomc/public_html/games/gourdgeous/

.PHONY: all debug test release clean flash flash-test upload
