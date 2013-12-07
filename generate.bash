#! /bin/bash

for file in $(ls  snippets/bit-reverse/*.s)
do
	cat $file | ./arm-cfg > temp.txt
	dot -Tps temp.txt -o $file.gs
	#ps2pdf snippits/bit-reverse/$file.eps
done

rm temp.*

