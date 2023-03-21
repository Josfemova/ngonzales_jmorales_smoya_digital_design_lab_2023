module left_shifter #(parameter WIDTH = 4)(
	input [WIDTH-1:0] A,B,
	output [WIDTH-1:0] data_out
);
	wire [$clog2(WIDTH)-1: 0] shift_ops;
	
	assign shift_ops = (B[WIDTH-1: $clog2(WIDTH)] == 0) ? B[$clog2(WIDTH)-1:0] : '1;
	
	genvar i, j;
	generate
	for (i=0; i<WIDTH; i=i+1) begin: generate_shifter
		wire [0:0] data_in[WIDTH-1:0];
		for (j=0; j<=i; j=j+1) begin: generate_data_in_0
				assign data_in[j] = A[i-j]; 
		end
		for (j=i+1; j<WIDTH; j=j+1) begin: generate_data_in_1
				assign data_in[j] = 0; 
		end
		mux_param #(.WIDTH(1), .SEL_WIDTH($clog2(WIDTH))) m(
			.data_in(data_in),
			.sel(shift_ops),
			.data_out(data_out[i])
		);
	end
	endgenerate

endmodule