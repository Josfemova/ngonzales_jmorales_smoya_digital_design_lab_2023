module contador (input logic clk, reset, 
					output reg [5:0] number);
					
	 always @(posedge clk) begin 
			number <= number + 1;
			if (reset) begin 
				number <= 0; 
			end
	end 

			 
endmodule

