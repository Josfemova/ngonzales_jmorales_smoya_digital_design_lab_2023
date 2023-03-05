module contador #(parameter SIZE = 6)(input logic clk, reset,
												output reg [SIZE-1:0] number,
												output logic [13:0] catodo);
												
											
	top UUT(number,catodo);
	always @(negedge clk or negedge reset) begin 
		
		if (!reset) 
		
			number <= -1; 
		else
		
			number <= number - 1;
			
			
	end 

			 
endmodule

