ARM-CFG-from-assembly-generator
===============================

Generates Control Flow Graph (CFG) from ARM assembly code.

### Compiling

Just compile the source with "make" as usual.


### Running

The binary "arm-cfg" generates some graph output that is to be loaded into "dot", which is a program provided by "graphviz". Graphviz is frealy available. To generate a CFG graph do as follows:
```
cat snippets/bit-reverse/krukar.s | ./arm-cfg > krukar.txt
dot -Tps krukar.txt -o krukar.gs
```

### Creating assembly with GCC

GCC 4.6 allows to save the assembly represntation of you program in an ASCII file. To obtain the assembly add the "-save-temps" flag as follows to the compiler:
```
arm-linux-gnueabihf-gcc -save-temps -c reverse.c
```
where "arm-linux-gnueabihf-gcc" is your favorite cross compiler (or native ARM compiler). This will generate a few files including *.s which is what you need to direct into this CFG generator.

Be aware that this CFG generator can parse any assembly file as long as the references in the assembly are formated as follows: ".L\d+".
