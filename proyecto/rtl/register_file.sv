module register_file(input logic [3:0] A1,
							input logic [3:0] A2,
							input logic [3:0] A3,
							input logic [31:0] WD3,
							input logic WE3,
							input logic clk,
							output logic [31:0] RD1,
							output logic [31:0] RD2
							);
logic [31:0] registros [15:0] ;

always @(posedge clk) begin
	if(WE3)
		registros[A3] <= WD3;
end

assign RD1 = registros[A1];
assign RD2 = registros[A2];

endmodule