module catodo_control(
input logic [3:0] digito_1,
input logic [3:0] digito_2,
output logic [13:0] catodo
);

always@(digito_1)

begin

	case(digito_1)
	
	4'd0:
		catodo[6:0] = 7'b0111111;
	4'd1:
		catodo[6:0] = 7'b0000110;
	4'd2:
		catodo[6:0] = 7'b1011011;
	4'd3:
		catodo[6:0] = 7'b1001111;
	4'd4:
		catodo[6:0] = 7'b1100110;
	4'd5:
		catodo[6:0] = 7'b1101101;
	4'd6:
		catodo[6:0] = 7'b1111101;
	4'd7:
		catodo[6:0] = 7'b0000111;
	4'd8:
		catodo[6:0] = 7'b1111111;
	4'd9:
		catodo[6:0] = 7'b1101111;
	
	endcase
end

always@(digito_2)
begin 	
	case(digito_2)
	
	4'd0:
		catodo[13:7] = 7'b0111111;
	4'd1:
		catodo[13:7] = 7'b0000110;
	4'd2:
		catodo[13:7] = 7'b1011011;
	4'd3:
		catodo[13:7] = 7'b1001111;
	4'd4:
		catodo[13:7] = 7'b1100110;
	4'd5:
		catodo[13:7] = 7'b1101101;
	4'd6:
		catodo[13:7] = 7'b1111101;
	4'd7:
		catodo[13:7] = 7'b0000111;
	4'd8:
		catodo[13:7] = 7'b1111111;
	4'd9:
		catodo[13:7] = 7'b1101111;
	
	endcase
end

endmodule
	