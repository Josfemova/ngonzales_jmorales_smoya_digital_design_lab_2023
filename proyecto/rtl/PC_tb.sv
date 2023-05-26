module PC_tb();

logic clk = 0;
always #5 clk = ~clk;
logic [31:0] PC_prev;
logic [31:0] PC;
logic rst =0;

initial begin
	  PC_prev <= 16'd0;
	  PC <= 16'd0;
end

PC dut(	.clk(clk),
			.reset(rst),
			.PC_prev(PC_prev),
			.PC_next(PC) );

endmodule