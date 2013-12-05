ARM-CFG-from-assembly-generator
===============================

Generates Control Flow Graph (CFG) from ARM assembly code.

### Compiling

Just compile the source with "make" as usual.


### Running

The binary "arm-cfg" generates some graph output that is to be loaded into "dot", which is a program provided by "graphviz". Graphviz is frealy available. To generate a CFG graph do as follows:
```
cat snippits/bit-reverse/krukar.s | ./arm-cfg > krukar.txt
dot -Tps krukar.txt -o krukar.gs
```

