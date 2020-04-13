EXES = collatz.exe

all: $(EXES)

collatz.exe: collatz.c
	# gcc -o $@ -Wall -Wextra -O3 -march=native -flto -fwhole-program $< -lgmp
	gcc -o $@ -Wall -Wextra -O3 -march=native -flto -fwhole-program $< -lgmp -ltcmalloc
	# gcc -o $@ -Wall -Wextra -g $< -lgmp

clean:
	rm -f $(EXES)
