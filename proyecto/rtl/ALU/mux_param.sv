module mux_param #(parameter WIDTH=4, SEL_WIDTH=1)(
	input [WIDTH-1:0] data_in[(2**SEL_WIDTH)-1:0],
	input [SEL_WIDTH-1:0] sel,
	output [WIDTH-1:0] data_out
);

assign data_out = data_in[sel];

endmodule
