module PC(
  input logic clk,
  input logic reset,
  input logic [31:0] PC_prev,
  output logic [31:0] PC_next
);


always @(posedge clk) begin
	if(reset)
		PC_next <= 0;
	else 
		PC_next <= PC_next + 1;

end
endmodule