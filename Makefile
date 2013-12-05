CC=g++
CFLAGS=-I.

arm-cfg: arm-cfg.o
	$(CC) -o arm-cfg arm-cfg.o

clean:
	rm -f *.o *~ arm-cfg
