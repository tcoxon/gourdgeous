
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
	openfl clean flash

upload: flash
	scp index.html Gourdgeous.swf gbjam2.html noncheaty.swf bytten.net:/home/tomc/public_html/games/gourdgeous/

.PHONY: all debug test release clean flash flash-test upload
