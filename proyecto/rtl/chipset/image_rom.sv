module image_rom
#(parameter WIDTH = 8, LENGTH = (256*256))
(
	input [31:0] r_addr,
	input clk, 
	output reg [(WIDTH-1):0] rd
);
	reg [WIDTH-1:0] rom[LENGTH-1:0];

	initial begin
		$readmemb("../../code/build/image.txt", rom);
	end

	always @ (posedge clk)
	begin
		rd <= rom[r_addr];
	end
endmodule
