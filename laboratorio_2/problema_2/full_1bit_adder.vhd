library IEEE; use IEEE.STD_LOGIC_1164.all;

entity full_1bit_adder is 
	port(x, y, z :in STD_LOGIC; 
		  s, c: out STD_LOGIC);
end;
architecture synth of full_1bit_adder is
signal w1,w2,w3 :STD_LOGIC;
begin
	w1 <= x xor y;
	w2 <= x and y;
	s <= w1 xor z;
	w3 <=  w1 and z;
   c <= w3 or w2; 
end;