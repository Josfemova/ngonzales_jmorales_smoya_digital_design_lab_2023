module zero_detect_param #(parameter WIDTH = 4)(
	input [WIDTH-1:0] data_in,
	output data_out
);

wire [WIDTH-2:0] chain;

generate 
	genvar i;
	for (i=0; i<(WIDTH-1); i=i+1) begin: generate_zdetect
		or x(chain[i], i==0 ? data_in[i] : chain[i-1] , data_in[i+1]);
	end
endgenerate

assign data_out = ~chain[WIDTH-2];

endmodule 