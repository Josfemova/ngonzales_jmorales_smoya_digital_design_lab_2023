library IEEE; use IEEE.STD_LOGIC_1164.all;

entity full_4bit_adder is 
	port(Z: in STD_LOGIC;
	     A, B:in STD_LOGIC_VECTOR(3 downto 0);
		  S: out STD_LOGIC_vector(3 downto 0);
		  C: out STD_LOGIC);
end;
architecture synth of full_4bit_adder is
signal c0, c1, c2: STD_LOGIC;
begin
   adder0: entity work.full_1bit_adder port map(x=> A(0), y=> B(0), z=>Z, s=>S(0), c=> c0);
	adder1: entity work.full_1bit_adder port map(x=> A(1), y=> B(1), z=>c0, s=>S(1), c=> c1);
	adder2: entity work.full_1bit_adder port map(x=> A(2), y=> B(2), z=>c1, s=>S(2), c=> c2);
	adder3: entity work.full_1bit_adder port map(x=> A(3), y=> B(3), z=>c2, s=>S(3), c=> C);
end;
