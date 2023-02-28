module contador(input logic clk, reset, 
					output logic [6:0] number);
					
					always_ff @(posedge clk)begin
					
						number <= number + 7'd1;
						
						if (reset) begin
						
							number <= 7'b0;
						end
					end
	

			 
endmodule