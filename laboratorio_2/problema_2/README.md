# Problema 2:

1. Diseñe un sumador completo de 4 bits con modelo de estructura en VHDL. 
Parta del diseño un sumador completo de 1 bit.

2. Realice un testbench para el sumador del punto anterior, en VHDL. Muestre 
las pruebas para al menos 4 valores diferentes de operandos.

3. Implemente el sumador completo en FPGA. Utilice los switches de las tarjeta 
para los datos de entrada, así como los display de 7 segmentos para mostrar el 
resultado correcto (en hexadecimal).

# Planteamiento de solución

Se requiere de 
- Un decodificador de 4 bits para un 7 segmentos
- un sumador de 4 bits programado de forma estructural
    - Es decir, se requiere de un sumador de 1 bit
- Testbench del modulo top 
- En el pin planner, connectar el output del decodificador de 7 segmentos a uno 
  de todos los 7 segmentos 
