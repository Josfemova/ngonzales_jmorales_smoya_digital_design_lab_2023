library IEEE; use IEEE.STD_LOGIC_1164.all;

entity problema_2 is 
	port(Z: in STD_LOGIC;
		  A,B: in STD_LOGIC_VECTOR(3 downto 0);
		  C: out STD_LOGIC;
		  Q: out STD_LOGIC_VECTOR(6 downto 0));
end;
architecture synth of problema_2 is 
signal S: STD_LOGIC_VECTOR(3 downto 0);
signal negQ: STD_LOGIC_VECTOR(6 downto 0);
begin
	full_4bit_adder0: entity work.full_4bit_adder port map(Z=>Z, A=>A, B=>B,S=>S, C=>C); 
	drv_7seg: entity work.driver_7segment port map(N=>S,Q=>negQ); 
	Q <= not negQ;
end;

