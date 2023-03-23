module laboratorio_3_tb;


parameter W=4;

reg [2:0] UC;
reg [3:0] Flags;

reg [W-1:0] A,B;
reg [6:0] Q;

laboratorio_3 DUT(
	.SwA(A),
	.SwB(B),
	.BtnUC(UC),
	.LedFlags(Flags),
	.SevenSegResult(Q)
);

initial begin
	A = 4'b0101;
	B = 4'b0001;
	UC = 3'b111;
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