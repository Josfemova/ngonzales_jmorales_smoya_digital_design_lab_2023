module reg_parallel_2 #(parameter WIDTH=8) (
    input [WIDTH-1:0] In,
    input reset, clk,
    output reg [WIDTH-1:0] Out
);
reg [WIDTH-1:0] state;

/*Asumiendo que clk funciona como enable*/
always @(posedge clk) begin
    if(!reset) begin
		state <= 0;
	 end
    else begin 
		state <= In;
		end
end

always @(*) begin
    Out = state;
end


endmodule