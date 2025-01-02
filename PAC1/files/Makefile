COMPILER=gcc
OPTIONS=-g -Wall -Wextra -Werror -Wshadow
COMPILE=$(COMPILER) $(OPTIONS)

all: app app2 func loppO3 loop mm

app: app.c
	$(COMPILE) $< lib.o -o $@ -Wall -O3

app2: app.c
	$(COMPILE) $< lib.o -o $@ -Wall

func: func.c
	$(COMPILE) $< lib.o -o $@ -Wall

loppO3: loop.c
	$(COMPILE) $< lib.o -o $@ -Wall -O3

loop: loop.c
	$(COMPILE) $< lib.o -o $@ -Wall

mm: mm.c
	$(COMPILE) $< lib.o -o $@ -Wall

clean:
	rm -f app app2 func loop loppO3 mm

.PHONY: clean

