library IEEE; use IEEE.STD_LOGIC_1164.all;

entity driver_7segment is 
	port(N: in STD_LOGIC_VECTOR(3 downto 0);
		  Q: out STD_LOGIC_vector(6 downto 0));
end;
architecture synth of driver_7segment is
begin
	WITH N SELECT 
	Q <= "0110000" WHEN X"1",
		 "1101101" WHEN X"2",
		 "1111001" WHEN X"3",
		 "0110011" WHEN X"4",
		 "1011011" WHEN X"5",
		 "1011111" WHEN X"6",
		 "1110000" WHEN X"7",
		 "1111111" WHEN X"8",
		 "1111011" WHEN X"9",
		 "1110111" WHEN X"A",
		 "0011111" WHEN X"B",
		 "1001110" WHEN X"C",
		 "0111101" WHEN X"D",
		 "1001111" WHEN X"E",
		 "1000111" WHEN X"F",
	     "1111110" WHEN OTHERS;
end;