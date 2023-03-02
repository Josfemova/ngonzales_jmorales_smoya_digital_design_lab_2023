module contador_tb();
	logic clk, reset;
	
	logic [5:0] num;
	
	
	

	
	
	contador #(6) count_6(.clk(clk),
						  .reset(reset),
						  .number(num));
	
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