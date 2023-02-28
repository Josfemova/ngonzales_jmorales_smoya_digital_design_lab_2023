module contador_tb();

	logic clktb, resettb, numbertb;
	
	contador count(clktb, resettb, numbertb);
	
	initial begin
		clktb = 0;
		resettb = 0;
		$monitor("counter: []", numbertb);
		#1000;
	end

endmodule