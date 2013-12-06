#! /bin/bash

cat snippets/bit-reverse/krukar.s | ./arm-cfg > test.txt
dot -Tps2 test.txt -o test.eps
ps2pdf test.eps
