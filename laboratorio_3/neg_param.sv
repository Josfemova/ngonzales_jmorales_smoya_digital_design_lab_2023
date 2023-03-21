module neg_param #(parameter WIDTH = 32)(
input logic [WIDTH-1:0] a,
output logic [WIDTH-1:0] out
);

genvar i;

generate
	for(i=0; i <WIDTH; i =i+1)
		begin: generate_neg
		assign out[i]= ~a[i]; 
		end
endgenerate

endmodule