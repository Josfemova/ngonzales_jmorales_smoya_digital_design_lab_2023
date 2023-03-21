module reg_parallel #(parameter WIDTH=8) (
    input [WIDTH-1:0] In,
    input reset, clk,
    output reg [WIDTH-1:0] Out
);
reg [WIDTH-1:0] state;

/*Asumiendo que clk funciona como enable*/
always @(posedge clk) begin
    if(!reset) state <= 0;
    else state <= In;
end

always @(*) begin
    Out = state;
end


endmodule
