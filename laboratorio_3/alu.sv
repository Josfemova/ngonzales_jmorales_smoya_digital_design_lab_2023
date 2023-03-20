module ALU #(parameter WIDTH=8)(
    input [WIDTH-1:0] A,B,
    input [2:0] ALUControl,
    output [3:0] ALUFlags,
    output [WIDTH-1:0] Result
);

wire cou, overflow_i0, overflow_i1, overflow_i2;
wire flag_overflow, flag_carry, flag_negative, flag_zero;
wire [WIDTH-1:0] OutB,Sum;

mux_param #(.WIDTH(WIDTH), .SEL_WIDTH(1)) sel_neg(
	.data_in({B,~B}),
	.sel(ALUControl[0]) ,
	.data_out(OutB)
);

sumador #(.WIDTH(WIDTH)) sum(
  .num1(A), 
  .num2(OutB),
  .c_i(ALUControl[0]), 
  .result(Sum),
  .c_o(cout)
 );

not not_ov2(overflow_i2, ALUControl[1]);
xor xor_ov1(overflow_i1, Sum[WIDTH-1], A[WIDTH-1]);
xnor xnor_ov0(overflow_i0, A[WIDTH-1], B[WIDTH-1], ALUControl[0]);
and and_ov(flag_overflow, overflow_i2, overflow_i1, overflow_i0);

and carry_and(flag_carry, cout, overflow_i2);

mux_param #(.WIDTH(WIDTH), .SEL_WIDTH(2)) op_sel(
	.data_in({A|B, A&B, Sum, Sum}),
	.sel(ALUControl[0]) ,
	.data_out(Result)
);

assign flag_negative = Result[WIDTH-1];

assign flag_zero = (Result == 0) ? 1'b1 : 1'b0;

assign ALUFlags = {flag_overflow, flag_carry, flag_negative, flag_zero};

 
endmodule
