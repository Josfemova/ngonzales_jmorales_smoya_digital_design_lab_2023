module instr_rom
#(parameter WIDTH = 32, LENGTH = 1024)
(
	input [(WIDTH-1):0] r_addr_a, r_addr_b, pc_next,
	input clk, 
	output reg [(WIDTH-1):0] rd_a, rd_b, pc_current
);
	reg [(WIDTH-1):0] pc = 1'b0;
	reg [(WIDTH-1):0] rom[(LENGTH-1):0];

	initial begin
		$readmemh("../code/build/program_le.txt", rom);
	end

	always @ (posedge clk)
	begin
		pc  <= pc_next;
		rd_a <= rom[r_addr_a];
		rd_b <= rom[r_addr_b];
	end
	
	assign pc_current = pc;
endmodule
