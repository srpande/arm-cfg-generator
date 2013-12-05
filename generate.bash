#! /bin/bash

cat snippits/bit-reverse/krukar.s | ./arm-cfg > test.txt &&  dot -Tps test.txt -o test.gs