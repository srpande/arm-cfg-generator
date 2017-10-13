CC=g++
CFLAGS=-I.

all: arm-cfg

arm-cfg.o: arm-cfg.cc
	$(CC) -std=c++11 -c -o arm-cfg.o arm-cfg.cc

arm-cfg: arm-cfg.o
	$(CC) -o arm-cfg arm-cfg.o

clean:
	rm -f *.o *~ arm-cfg
