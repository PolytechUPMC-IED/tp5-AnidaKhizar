CC=gcc
CFLAGS=-O3 -Wall -funroll-loops 
LDLIBS=-lpng

all: pbm2png pbm2eps9

pbm2png:pbm2png.c
	$(CC) $(CFLAGS) -s -o pbm2png pbm2png.c $(LDLIBS)

pbm2eps9: pbm2eps9.o printer.o
	$(CC) -s -o pbm2eps9 pbm2eps9.o printer.o

#Question2
#pbm2eps9.o: pbm2eps9.c printer.h
#	$(CC) $(CFLAGS) -c -o pbm2eps9.o pbm2eps9.c

#printer.o: printer.c
#	$(CC) $(CFLAGS) -c -o printer.o printer.c

%.o: %.c
	$(CC) $(CFLAGS) -c -o $@ $<

pbm2eps9.o: pbm2eps9.c printer.h
printer.o: printer.c

clean:
	rm -f printer.o pbm2eps9.o pbm2png pbm2eps9
