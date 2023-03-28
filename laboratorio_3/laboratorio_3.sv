module laboratorio_3(
	input [3:0] SwA, SwB,	
	input [2:0] BtnUC,
	input logic reset,clk,
	output [3:0] LedFlags,
	output [6:0] SevenSegResult
);

wire [3:0] result_to_7seg;
wire [6:0] seven_aux;
wire [2:0] btn_aux;

assign btn_aux = ~BtnUC;

alu #(.WIDTH(4)) alu_top(
	.A(SwA),
	.B(SwB),
	.reset(reset),
	.clk(clk),
	.ALUControl(btn_aux),
	.ALUFlags(LedFlags),
	.Result(result_to_7seg)
);

seven_segment_driver seven_seg(
	.data_in(result_to_7seg),
	.data_out(seven_aux)
);

assign SevenSegResult = ~seven_aux;

endmodule