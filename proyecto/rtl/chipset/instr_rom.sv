module instr_rom
#(parameter WIDTH = 32, LENGTH = 1024)
(
	input [(WIDTH-1):0] addr_a, addr_b, pc_next,
	input clk, 
	output reg [(WIDTH-1):0] q_a, q_b, pc_current
);
	reg [(WIDTH-1):0] pc = 1'b0;
	reg [(WIDTH-1):0] rom[(LENGTH-1):0];

	initial begin
		$readmemh("../code/build/program_le.txt", rom);
	end

	always @ (posedge clk)
	begin
		pc  <= pc_next;
		q_a <= rom[addr_a];
		q_b <= rom[addr_b];
	end
	
	assign pc_current = pc;
endmodule
