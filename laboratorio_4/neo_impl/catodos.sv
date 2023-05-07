module catodo_control(
input logic [3:0] digito_1,
input logic [3:0] digito_2,
input logic [3:0] digito_3,
input logic [3:0] digito_4,
output logic [27:0] catodo
);

always_comb begin
	case(digito_1)
        6'd0: catodo[6:0] = 7'b0111111;
        6'd1: catodo[6:0] = 7'b0000110;
        6'd2: catodo[6:0] = 7'b1011011;
        6'd3: catodo[6:0] = 7'b1001111;
        6'd4: catodo[6:0] = 7'b1100110;
        6'd5: catodo[6:0] = 7'b1101101;
        6'd6: catodo[6:0] = 7'b1111101;
        6'd7: catodo[6:0] = 7'b0000111;
        6'd8: catodo[6:0] = 7'b1111111;
        6'd9: catodo[6:0] = 7'b1101111;
        default: catodo[6:0] = 7'b1111111;
    endcase
	case(digito_2)
        6'd0: catodo[13:7] = 7'b0111111;
        6'd1: catodo[13:7] = 7'b0000110;
        6'd2: catodo[13:7] = 7'b1011011;
        6'd3: catodo[13:7] = 7'b1001111;
        6'd4: catodo[13:7] = 7'b1100110;
        6'd5: catodo[13:7] = 7'b1101101;
        6'd6: catodo[13:7] = 7'b1111101;
        6'd7: catodo[13:7] = 7'b0000111;
        6'd8: catodo[13:7] = 7'b1111111;
        6'd9: catodo[13:7] = 7'b1101111;
        default: catodo[13:7] = 7'b1111111;
    endcase
    case(digito_3)
        6'd0: catodo[20:14] = 7'b0111111;
        6'd1: catodo[20:14] = 7'b0000110;
        6'd2: catodo[20:14] = 7'b1011011;
        6'd3: catodo[20:14] = 7'b1001111;
        6'd4: catodo[20:14] = 7'b1100110;
        6'd5: catodo[20:14] = 7'b1101101;
        6'd6: catodo[20:14] = 7'b1111101;
        6'd7: catodo[20:14] = 7'b0000111;
        6'd8: catodo[20:14] = 7'b1111111;
        6'd9: catodo[20:14] = 7'b1101111;
        default: catodo[20:14] = 7'b1111111;
    endcase
    case(digito_4)
        6'd0: catodo[27:21] = 7'b0111111;
        6'd1: catodo[27:21] = 7'b0000110;
        6'd2: catodo[27:21] = 7'b1011011;
        6'd3: catodo[27:21] = 7'b1001111;
        6'd4: catodo[27:21] = 7'b1100110;
        6'd5: catodo[27:21] = 7'b1101101;
        6'd6: catodo[27:21] = 7'b1111101;
        6'd7: catodo[27:21] = 7'b0000111;
        6'd8: catodo[27:21] = 7'b1111111;
        6'd9: catodo[27:21] = 7'b1101111;
        default: catodo[27:21] = 7'b1111111;
    endcase
end

endmodule
