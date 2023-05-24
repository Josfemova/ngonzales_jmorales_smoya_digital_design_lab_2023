module register_file_tb;

  
	logic [3:0] A1, A2, A3;
	logic [31:0] WD3, RD1, RD2;
	logic WE3;

	logic clk = 0;
	always #5 clk = ~clk;

	register_file dut (
	 .A1(A1),
	 .A2(A2),
	 .A3(A3),
	 .WD3(WD3),
	 .WE3(WE3),
	 .clk(clk),
	 .RD1(RD1),
	 .RD2(RD2)
	);

initial begin
	#200; 

	// Escritura




	A3 = 1;
	WD3 = 32'h12345678;
	WE3 = 1;
	#10;
	WE3 = 0;

	A3 = 2;
	WD3 = 32'h87654321;
	WE3 = 1;
	#10;
	WE3 = 0;
	#10;
	A1 = 1;
	A2 = 2;

	#10;

	$display("RD1: %h", RD1);
	$display("RD2: %h", RD2);

  end

endmodule