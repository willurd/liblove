LOVE_FILE = build/$(shell basename `pwd`).love

main:
	make clean
	mkdir build
	zip -r $(LOVE_FILE) . -x .git\* -x build/

love:
	love .

run: $(LOVE_FILE)
	love $(LOVE_FILE)

$(LOVE_FILE) :
	make

clean:
	rm -rf build
