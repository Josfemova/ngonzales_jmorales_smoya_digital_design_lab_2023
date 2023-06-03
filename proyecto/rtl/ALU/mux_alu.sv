module mux_alu #(parameter WIDTH=32)(
    input [WIDTH-1:0] op0, op1, op2, op3, op4, op5, op6, op7,  
    input [2:0] sel,
    output logic [WIDTH-1:0] data_out
);

always_comb begin 
case (sel)
    3'b000: data_out = op0;
    3'b001: data_out = op1;
    3'b010: data_out = op2;
    3'b011: data_out = op3;
    3'b100: data_out = op4;
    3'b101: data_out = op5;
    3'b110: data_out = op6;
    3'b111: data_out = op7;
endcase
end

endmodule 