module contador #(parameter SIZE = 6)(input logic clk, reset,
												input reg [SIZE-1:0] start,
												output reg [SIZE-1:0] number);
	
	 always @(posedge clk) begin 
			number <= number - 1;
			if (reset) begin 
				number <= start; 
			end
	end 

			 
endmodule

