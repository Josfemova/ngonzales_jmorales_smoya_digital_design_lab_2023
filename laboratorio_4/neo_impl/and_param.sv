module and_param #(parameter WIDTH = 32)(
input logic [WIDTH-1:0] data_in_0, data_in_1,
output logic [WIDTH-1:0] data_out
);

genvar i;

generate
	for(i=0; i <WIDTH; i =i+1)
		begin: generate_and
		and and_x(data_out[i], data_in_0[i], data_in_1[i]);
		end
endgenerate

endmodule
