module alu #(parameter WIDTH=8)(
    input signed [WIDTH-1:0] A,B,
    input [2:0] ALUControl,
    output [3:0] ALUFlags,
    output [WIDTH-1:0] Result
);

neg_param #(.WIDTH(WIDTH)) notA(
	.data_in(A),
	.data_out(negA)
);

neg_param #(.WIDTH(WIDTH)) notB(
	.data_in(B),
	.data_out(negB)
);

or_param #(.WIDTH(WIDTH)) orAB(
	.data_in_0(A),
	.data_in_1(B),
	.data_out(AorB)
);

and_param #(.WIDTH(WIDTH)) andAB(
	.data_in_0(A),
	.data_in_1(B),
	.data_out(AandB)
);


wire flag_overflow, flag_carry, flag_negative, flag_zero, cout, overflow_i0, overflow_i1, overflow_i2, is_sum;
wire signed [WIDTH-1:0] negA, negB, AorB, AandB, OutB, Sum, OutLSR, OutRSR, OutRSRArithm;
wire [WIDTH-1:0] OptionsB[1:0];

assign OptionsB[0] = B;
assign OptionsB[1] = negB;

mux_param #(.WIDTH(WIDTH), .SEL_WIDTH(1)) sel_neg(
	.data_in(OptionsB),
	.sel(ALUControl[0]),
	.data_out(OutB)
);

sumador #(.WIDTH(WIDTH)) sum(
  .num1(A), 
  .num2(OutB),
  .c_i(ALUControl[0]), 
  .result(Sum),
  .c_o(cout)
 );
 

// not del libro es cambiada por nor al agregar una linea de control de ALU
// not not_ov2(overflow_i2, ALUControl[1]);
nor is_sum_op(is_sum, ALUControl[1], ALUControl[2]);
xor xor_ov1(overflow_i1, Sum[WIDTH-1], A[WIDTH-1]);
xnor xnor_ov0(overflow_i0, A[WIDTH-1], B[WIDTH-1], ALUControl[0]);
and and_ov(flag_overflow, is_sum, overflow_i1, overflow_i0);

and carry_and(flag_carry, cout, is_sum);

left_shifter #(.WIDTH(WIDTH)) lsr(
	.A(A), 
	.B(B), 
	.data_out(OutLSR)
);

right_shifter #(.WIDTH(WIDTH)) rsr(
	.A(A), 
	.B(B), 
	.shift_bit(1'b0),
	.data_out(OutRSR)
);

right_shifter #(.WIDTH(WIDTH)) rsr_arithm(
	.A(A), 
	.B(B), 
	.shift_bit(A[WIDTH-1]),
	.data_out(OutRSRArithm)
);

mux_param #(.WIDTH(WIDTH),.SEL_WIDTH(3)) op_sel(
	.data_in('{OutRSRArithm, OutRSR, OutLSR , AorB, AandB, negA, Sum, Sum}),
	.sel(ALUControl),
	.data_out(Result)
);

zero_detect_param #(.WIDTH(WIDTH)) zd(
	.data_in(Result),
	.data_out(flag_zero)
);

assign flag_negative = Result[WIDTH-1];

assign ALUFlags = {flag_overflow, flag_carry, flag_negative, flag_zero};
 
endmodule
