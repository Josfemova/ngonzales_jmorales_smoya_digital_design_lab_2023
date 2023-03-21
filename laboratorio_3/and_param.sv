module and_param #(parameter WIDTH = 32)(
input logic [WIDTH-1:0] a, b,
output logic [WIDTH-1:0] out
);

genvar i;

generate
	for(i=0; i <WIDTH; i =i+1)
		begin: generate_and
		and and_x(out[i], a[i], b[i]);
		end
endgenerate

endmodule