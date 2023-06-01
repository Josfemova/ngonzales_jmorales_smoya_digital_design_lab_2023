module image_rom
#(parameter WIDTH = 8, LENGTH = (256*256))
(
	input [31:0] addr_a,
	input clk, 
	output reg [(WIDTH-1):0] rd_a
);
	reg [WIDTH-1:0] rom[LENGTH-1:0];

	initial begin
		$readmemb("../../code/build/image.txt", rom);
	end

	always @ (posedge clk)
	begin
		rd_a <= rom[addr_a];
	end
endmodule
