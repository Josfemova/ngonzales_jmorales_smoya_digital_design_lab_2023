/*Image Ram module*/
module vga_framebuffer_ram #(parameter DATA_WIDTH=8, parameter LENGTH=256*256)
(
	input we, r_clk, w_clk,
	input [(DATA_WIDTH-1):0] wd,
	input [31:0] r_addr, w_addr,
	output reg [(DATA_WIDTH-1):0] rd
);

	// Declare the RAM variable
	reg [DATA_WIDTH-1:0] ram[LENGTH-1:0];
	
	always @ (posedge w_clk)
	begin
		// Write
		if (we)
			ram[w_addr] <= wd;
	end
	
	always @ (posedge r_clk)
	begin
		// Read 
		rd <= ram[r_addr];
	end
	

endmodule
