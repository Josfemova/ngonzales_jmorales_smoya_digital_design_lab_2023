module right_shifter #(parameter WIDTH = 4)(
	input [WIDTH-1:0] A,B,
	input shift_bit,
	output [WIDTH-1:0] data_out
);
	wire [$clog2(WIDTH)-1: 0] shift_ops;
	wire not_max_shift;
	wire [WIDTH-1:0] data_out_aux;
	
	assign shift_ops =  (B[WIDTH-1: $clog2(WIDTH)] == 0) ? B[$clog2(WIDTH)-1:0]: '1;
	assign not_max_shift = (B[WIDTH-1: $clog2(WIDTH)] == 0) ? 1'b1 : shift_bit;
	
	genvar i, j;
	generate
	for (i=(WIDTH-1); i>=0; i=i-1) begin: generate_shifter
		wire [0:0] data_in[WIDTH-1:0];
		for (j=0; (WIDTH-1-j) >= i; j=j+1) begin: generate_data_in_0
				assign data_in[j] = A[i+j]; 
		end
		for (j=(WIDTH-i); j<WIDTH; j=j+1) begin: generate_data_in_1
				assign data_in[j] = shift_bit; 
		end
		mux_param #(.WIDTH(1), .SEL_WIDTH($clog2(WIDTH))) m(
			.data_in(data_in),
			.sel(shift_ops),
			.data_out(data_out_aux[i])
		);	
	end
	endgenerate
	wire last_output;
	and andx(last_output, data_out_aux[0], not_max_shift);
	
	assign data_out = {data_out_aux[WIDTH-1:1], last_output};

endmodule