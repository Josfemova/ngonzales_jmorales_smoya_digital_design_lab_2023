module extend_tb();

logic [23:0] instruction = 24'b010111001011010111110110;
logic [1:0] ImmSrc;
logic [31:0] ExtImm;

extend dut(.Instr(instruction), .ImmSrc(ImmSrc), .ExtImm(ExtImm));


initial begin
#10
ImmSrc = 2'b00;
#10
ImmSrc = 2'b01;
#10
ImmSrc = 2'b10;
#10
ImmSrc = 2'b11;

end

endmodule