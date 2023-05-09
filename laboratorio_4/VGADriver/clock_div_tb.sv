module clock_div_tb;
	reg clk;
	reg ctest = 1'b0;
	wire c2,c3,c4, cs;
	
	assign cs = ctest;
	
	
	clock_div #(2) clk_div2 (.clk_in(clk), .clk_out(c2));
	clock_div #(3) clk_div3 (.clk_in(clk), .clk_out(c3));
	clock_div #(4) clk_div4(.clk_in(clk), .clk_out(c4));

	always @(posedge clk) begin
		ctest <= ~ctest;
	end
	
initial begin
    clk=0;
end 
always begin 
    #5 clk = ~ clk;
end 


	
	initial begin
	#20;
	end 
	

endmodule