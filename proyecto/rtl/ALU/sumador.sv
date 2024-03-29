module sumador #(parameter WIDTH = 32)(
	input [WIDTH-1:0] num1,
	input [WIDTH-1:0] num2,
	input c_i,
	output [WIDTH-1:0] result,
	output c_o
);	
	logic carry_out;
	
	logic [WIDTH-1:0] carry_reg;
	
	genvar i;
	generate
	for (i=0; i<WIDTH; i=i+1)
		begin: generate_adder
			if (i==0)
				full_adder f(num1[0], num2[0], c_i, result[0], carry_reg[0]);
			else
				full_adder f(num1[i], num2[i], carry_reg[i-1], result[i], carry_reg[i]);
		end
	assign carry_out = carry_reg[WIDTH-1];
	endgenerate
	assign c_o = carry_reg[WIDTH-1];
													  
endmodule

module half_adder(x,y,s,c);
   input x,y;
   output s,c;
   assign s=x^y;
   assign c=x&y;
endmodule

module full_adder(x,y,c_in,s,c_out);
   input x,y,c_in;
   output s,c_out;
 assign s = (x^y) ^ c_in;
 assign c_out = (y&c_in)| (x&y) | (x&c_in);
endmodule