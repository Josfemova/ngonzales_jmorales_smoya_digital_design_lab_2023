/*Image Ram module*/
module vga_framebuffer_ram #(parameter DATA_WIDTH=8, parameter LENGTH=256*256)
(
	input [(DATA_WIDTH-1):0] wdata,
	input [31:0] read_addr, write_addr,
	input we, read_clock, write_clock,
	output reg [(DATA_WIDTH-1):0] rdata
);

	// Declare the RAM variable
	reg [DATA_WIDTH-1:0] ram[LENGTH-1:0];
	
	always @ (posedge write_clock)
	begin
		// Write
		if (we)
			ram[write_addr] <= wdata;
	end
	
	always @ (posedge read_clock)
	begin
		// Read 
		rdata <= ram[read_addr];
	end
	

endmodule