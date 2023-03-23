module main_tb;

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

initial repeat(2) begin
	A = $random;
	B = $random;
	UC = 3'b000;
	#5;
	UC = 3'b001;
	#5;
	UC = 3'b010;
	#5;
	UC = 3'b011;
	#5;
	UC = 3'b100;
	#5;
	UC = 3'b101;
	#5;
	UC = 3'b110;
	#5;
	UC = 3'b111;
	#5;
	
end

endmodule