module contador_tb();
	logic clk, reset;
	
	logic [5:0] num;
	logic [13:0] cat;
	
	
	

	
	
	contador #(6) count_6(.clk(clk),
						  .reset(reset),
						  .number(num),
						  .catodo(cat));
	
	initial begin 
		
		clk=0;
		forever #5 clk=~clk;
	end
	
	initial begin
		
		reset=0;
		#20;
		reset=1;
		#100
		reset = 0;
		
		#100
		reset = 1;
		#100
		reset = 0;
		
	end
	

endmodule