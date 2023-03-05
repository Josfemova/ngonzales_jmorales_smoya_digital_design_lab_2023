module contador_tb();
	logic clk, reset ;
	
	logic [1:0] num_2bit;
	logic [3:0] num_4bit;
	logic [5:0] num_6bit;
	logic [13:0] display_6bit;
	
	
	

	
	
	contador #(6) count_6(.clk(clk),
						  .reset(reset),
						  .number(num_6bit),
						  .catodo(display_6bit));
	contador #(4) count_4(.clk(clk),
						  .reset(reset),
						  .number(num_4bit));
	contador #(2) count_2(.clk(clk),
						  .reset(reset),
						  .number(num_2bit));
						  

	initial begin
		
		reset=0;
		#10
		assert(num_2bit == 3) else
		$error("2bit reset failed");
		
		assert(num_4bit == 15)else
		$error("4bit reset failed");
		
		assert(num_6bit == 63)else
		$error("6bit reset failed");
		reset = 1;

	end
	
	initial begin 
		clk = 0;
		forever #5 clk=~clk;
		
	end
	
	always @ (negedge clk) begin
		if(num_2bit == 0) begin
			$display("2bit finished counting to ", num_2bit);
		end
		
		if(num_4bit == 0) begin
			$display("4bit finished counting to ", num_4bit);
		end
	
		if(num_6bit == 0) begin
			$display("6bit finished counting to ", num_6bit);
			$finish;
		end
		
	end
	

endmodule