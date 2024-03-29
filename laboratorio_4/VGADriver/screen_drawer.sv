`define sprite_w 25
`define lowres 1 // escala 4:1. Alternativa es 2:1 si comenta este define

module screen_drawer(
	input [9:0] x,y,
	input [3:0] gmatrix [0:3][0:3],
	input [1:0] draw_state,
	output reg [23:0] rgb_color
);
logic [11:0] sprite_val;
logic is_sprite;
logic [17:0] sprite_offset;
logic [9:0] offset_x, offset_y;

parameter sprite_bg = 24'hf7e1b2;
parameter color_bg = 24'hf2e3c4;

reg [23:0] sprite_sheet[(`sprite_w*`sprite_w * 12)-1:0];
reg [23:0] sprite_msgs[(25*100*2)-1:0];
initial begin
	`ifdef lowres
	$readmemh("sprite_sheet25x25.txt", sprite_sheet);
	`else
	$readmemh("sprite_sheet50x50.txt", sprite_sheet);
	`endif
	$readmemh("sprite_msgs.txt", sprite_msgs);
end

// always para detectar caso
always_comb begin
	sprite_val = gmatrix[0][0];
	offset_x = 10'd0;
	offset_y = 10'd0;
	is_sprite = 1'b1;
	if ((y <= 25 || y >= 455 || x <= 105 || x >= 535) 
        // divisiones 
        || (x >= 205 && x <= 215)
        || (x >= 315 && x <= 325)
        || (x >= 425 && x <= 435)
        || (y >= 125 && y <= 135)
        || (y >= 235 && y <= 245) 
        || (y >= 345 && y <= 355)) begin
		  	is_sprite = 1'b0;
    end
	 
	 //primer fila
    else if(y>25 && y<125) begin
		 offset_y = 10'd25;
		 if(x > 105 && x<205) begin
			sprite_val = gmatrix[0][0];
			offset_x = 10'd105;
		 end
		 else if(x > 215 && x < 315) begin
			sprite_val = gmatrix[0][1];
			offset_x = 10'd215;
		 end
		 else if(x > 325 && x < 425) begin
			sprite_val = gmatrix[0][2];
			offset_x = 10'd325;
		 end
		 else if(x > 435 && x < 535) begin
			sprite_val = gmatrix[0][3];
			offset_x = 10'd435;
		 end
    end
	 
	 //segunda fila
    else if(y>135 && y<235) begin
		 offset_y = 10'd135;
		 if(x > 105 && x<205) begin
			sprite_val = gmatrix[1][0];
			offset_x = 10'd105;
		 end
		 else if(x > 215 && x < 315) begin
			sprite_val = gmatrix[1][1];
			offset_x = 10'd215;
		 end
		 else if(x > 325 && x < 425) begin
			sprite_val = gmatrix[1][2];
			offset_x = 10'd325;
		 end
		 else if(x > 435 && x < 535) begin
			sprite_val = gmatrix[1][3];
			offset_x = 10'd435;
		 end
    end
	 
	 //tercer fila
    else if(y>245 && y<345) begin
		 offset_y = 10'd245;
		 if(x > 105 && x<205) begin
			sprite_val = gmatrix[2][0];
			offset_x = 10'd105;
		 end
		 else if(x > 215 && x < 315) begin
			sprite_val = gmatrix[2][1];
			offset_x = 10'd215;
		 end
		 else if(x > 325 && x < 425) begin
			sprite_val = gmatrix[2][2];
			offset_x = 10'd325;
		 end
		 else if(x > 435 && x < 535) begin
			sprite_val = gmatrix[2][3];
			offset_x = 10'd435;
		 end
    end
	 
	 //cuarta fila
    else if(y>355 && y<455) begin
		 offset_y = 10'd355;
		 if(x > 105 && x<205) begin
			sprite_val = gmatrix[3][0];
			offset_x = 10'd105;
		 end
		 else if(x > 215 && x < 315) begin
			sprite_val = gmatrix[3][1];
			offset_x = 10'd215;
		 end
		 else if(x > 325 && x < 425) begin
			sprite_val = gmatrix[3][2];
			offset_x = 10'd325;
		 end
		 else if(x > 435 && x < 535) begin
			sprite_val = gmatrix[3][3];
			offset_x = 10'd435;
		 end
    end
	 else
		is_sprite = 1'b0;
end

always_comb begin
	sprite_offset = 0;
		if(is_sprite == 1'b1) begin
		case(sprite_val)		
			4'd1  : sprite_offset = 000;
			4'd2  : sprite_offset = `sprite_w * `sprite_w *1;
			4'd3  : sprite_offset = `sprite_w * `sprite_w *2;
			4'd4  : sprite_offset = `sprite_w * `sprite_w *3;
			4'd5  : sprite_offset = `sprite_w * `sprite_w *4;
			4'd6  : sprite_offset = `sprite_w * `sprite_w *5;
			4'd7  : sprite_offset = `sprite_w * `sprite_w *6;
			4'd8  : sprite_offset = `sprite_w * `sprite_w *7;
			4'd9  : sprite_offset = `sprite_w * `sprite_w *8;
			4'd10 : sprite_offset = `sprite_w * `sprite_w *9;
			4'd11 : sprite_offset = `sprite_w * `sprite_w *10;
			default: sprite_offset =   0000;
		endcase

			if(sprite_val != 12'd0)
			`ifdef lowres
				rgb_color = sprite_sheet[sprite_offset + ((x-offset_x) >> 2) + 25*((y-offset_y) >> 2)];
			`else
				rgb_color = sprite_sheet[sprite_offset + ((x-offset_x) >> 1) + 50*((y-offset_y) >> 1)];
			`endif
			else 
				rgb_color = sprite_bg;
		end else begin
			case(draw_state)
				2'b00 : rgb_color = color_bg;
				2'b01 : begin //win
					if(x > 2 && x<102 && y > 40 && y < 440) 
						rgb_color = sprite_msgs[((x-3) >> 2) + 25*((y-41) >> 2)];
					else 
						rgb_color = color_bg;
				end
				2'b10 : begin //lose
					if(x > 2 && x<102 && y > 40 && y < 440) 
						rgb_color = sprite_msgs[(100*25) + ((x-3) >> 2) + 25*((y-41) >> 2)];
					else 
						rgb_color = color_bg;
				end
				default: rgb_color = 24'h000000; 
			endcase 
		end
end
endmodule
