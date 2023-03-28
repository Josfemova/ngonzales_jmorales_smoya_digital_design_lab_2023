module reg_parallel #(parameter WIDTH=8) (
    input [WIDTH-1:0] In_1,
	 input [WIDTH-1:0] In_2,
    input reset, clk,
    output reg [WIDTH-1:0] Out_A,
	 output reg [WIDTH-1:0] Out_B
);
reg [WIDTH-1:0] state_1;
reg [WIDTH-1:0] state_2;

/*Asumiendo que clk funciona como enable*/
always @(posedge clk) begin
    if(!reset) begin
		state_1 <= 0;
		state_2 <= 0;
	 end
    else begin 
		state_1 <= In_1;
		state_2 <= In_2;
		end
end

always @(*) begin
    Out_A = state_1;
	 Out_B = state_2;
end


endmodule
