library IEEE; use IEEE.STD_LOGIC_1164.all;

entity full_4bit_adder_tb is
end;
architecture test of full_4bit_adder_tb is
signal A,B,S: STD_LOGIC_VECTOR(3 downto 0);
signal Z, C: STD_LOGIC;
begin
	dut: entity work.full_4bit_adder port map(Z=>Z, A=>A, B=>B, S=>S, C=>C); 
	stimulus: process begin
		Z <= '0';
		-- Solo el operando A
		A <= X"4";
		B <= X"0";
		wait for 2 ns;
		-- Solo el operando B
		A <= X"0";
		B <= X"4";
		wait for 2 ns;
		-- Ambos operandos activos
		A <= X"4";
		B <= X"2";
		wait for 2 ns;
		-- Limite antes de llegar a un carry 
		A <= X"5";
		B <= X"A";
		wait for 2 ns;
		-- Caso con Carry de salida
		A <= X"A";
		B <= X"A";
		wait for 2 ns;
		-- Caso con Carry de entrada
		Z <= '1';
		A <= X"A";
		B <= X"3";
		wait for 2 ns;
		-- Caso con Carry de entrada y salida
		A <= X"A";
		B <= X"5";
		wait for 2 ns;
		wait;
	end process stimulus;
end;
