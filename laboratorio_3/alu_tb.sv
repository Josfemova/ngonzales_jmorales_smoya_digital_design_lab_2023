module alu_tb;

parameter W=4;

reg [2:0] UC;
reg [3:0] Flags;

reg [W-1:0] A,B,Q;

alu #(.WIDTH(W)) DUT(
	.A(A),
	.B(B),
	.ALUControl(UC),
	.ALUFlags(Flags),
	.Result(Q)
);

initial begin
	A = 4'b1111;
	B = 4'b0001;
	UC = 3'b101;
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