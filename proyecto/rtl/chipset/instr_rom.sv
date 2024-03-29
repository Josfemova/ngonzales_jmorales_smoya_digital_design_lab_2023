module instr_rom
#(parameter WIDTH = 32, LENGTH = 256)
(
	input clk_a, clk_b, 
	input [(WIDTH-1):0] r_addr_a, r_addr_b,
	output logic [(WIDTH-1):0] rd_a, rd_b
);
	reg [(WIDTH-1):0] rom[(LENGTH-1):0];

	initial begin
		//$readmemh("/home/josfemova/REPOSITORIOS/ngonzales_jmorales_smoya_digital_design_lab_2023/proyecto/rtl/memfile.dat",rom, 0, 22);
		//$readmemh("../../code/build/program_le.txt", rom);
		$readmemh("/home/josfemova/REPOSITORIOS/ngonzales_jmorales_smoya_digital_design_lab_2023/proyecto/code/build/program_le.txt",rom);
	end

	always @(posedge clk_a)
	begin
		rd_a <= rom[r_addr_a[WIDTH-1:2]];
	end

	always @(posedge clk_b)
	begin
		rd_b <= rom[r_addr_b[WIDTH-1:2]];
	end
endmodule
