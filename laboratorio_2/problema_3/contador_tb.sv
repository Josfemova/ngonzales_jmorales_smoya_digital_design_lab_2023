module contador_tb();
	logic clk, reset;
	
	logic [6:0] num;
	logic [6:0] start = 6'b001011;
	
	contador #(6) count_6(.clk(clk),
						  .reset(reset),
						  .number(num),
						  .start(start));
	
	initial begin 
		
		clk=0;
		forever #5 clk=~clk;
	end
	
	initial begin
		reset=1;
		#20;
		reset=0;
		#100
		reset = 1;
		#100
		reset = 0;
	end
	

endmodule