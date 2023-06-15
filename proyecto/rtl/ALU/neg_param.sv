module neg_param #(parameter WIDTH = 32)(
input logic [WIDTH-1:0] data_in,
output logic [WIDTH-1:0] data_out
);

genvar i;

generate
	for(i=0; i <WIDTH; i =i+1)
		begin: generate_neg
		assign data_out[i]= ~data_in[i]; 
		end
endgenerate

endmodule