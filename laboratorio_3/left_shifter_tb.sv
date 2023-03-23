module left_shifter_tb;

reg[3:0] A, B, Q;

left_shifter #(.WIDTH(4)) DUT(
	.A(A),
	.B(B),
	.data_out(Q)
);

initial begin
	A = 4'b1111;
	B = 4'b0001;
	#5;
	B = 4'b0010;
	#5;
	B = 4'b0011;
	#5;
	B = 4'b0100;
	#5;
	B = 4'b0101;
	#5;
end

endmodule