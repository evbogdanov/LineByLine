make all:
	clang LBLReader.m main.m  -fobjc-arc -fmodules -o lbl

test:
	./lbl test1.txt test2.txt notfound.txt

clean:
	rm lbl
