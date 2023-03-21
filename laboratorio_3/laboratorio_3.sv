module laboratorio_3(
	input [3:0] SwA, SwB,	
	input [2:0] BtnUC,
	output [3:0] LedFlags,
	output [6:0] SevenSegResult
);

wire [3:0] result_to_7seg;

alu #(.WIDTH(4)) alu_top(
	.A(SwA),
	.B(SwB),
	.ALUControl(BtnUC),
	.ALUFlags(LedFlags),
	.Result(result_to_7seg)
);

seven_segment_driver seven_seg(
	.data_in(result_to_7seg),
	.data_out(SevenSegResult)
);

endmodule