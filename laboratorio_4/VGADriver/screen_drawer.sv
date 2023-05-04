module screen_drawer(
	input [9:0] x,y,
	input [11:0] game_state [3:0][3:0],
	output reg [23:0] rgb_color
);
logic [11:0] sprite_val;
logic is_sprite;
logic [9:0] offset_x, offset_y;

/*
reg [23:0] sprite_sheet[110000-1:0];
initial begin
	$readmemh("sprite_sheet.txt", sprite_sheet);
end
*/

// always para detectar caso
always_comb begin
	sprite_val = game_state[0][0];
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
			sprite_val = game_state[0][0];
			offset_x = 10'd105;
		 end
		 else if(x > 215 && x < 315) begin
			sprite_val = game_state[0][1];
			offset_x = 10'd215;
		 end
		 else if(x > 325 && x < 425) begin
			sprite_val = game_state[0][2];
			offset_x = 10'd325;
		 end
		 else if(x > 435 && x < 535) begin
			sprite_val = game_state[0][3];
			offset_x = 10'd435;
		 end
    end
	 
	 //segunda fila
    else if(y>135 && y<235) begin
		 offset_y = 10'd135;
		 if(x > 105 && x<205) begin
			sprite_val = game_state[1][0];
			offset_x = 10'd105;
		 end
		 else if(x > 215 && x < 315) begin
			sprite_val = game_state[1][1];
			offset_x = 10'd215;
		 end
		 else if(x > 325 && x < 425) begin
			sprite_val = game_state[1][2];
			offset_x = 10'd325;
		 end
		 else if(x > 435 && x < 535) begin
			sprite_val = game_state[1][3];
			offset_x = 10'd435;
		 end
    end
	 
	 //tercer fila
    else if(y>245 && y<345) begin
		 offset_y = 10'd245;
		 if(x > 105 && x<205) begin
			sprite_val = game_state[2][0];
			offset_x = 10'd105;
		 end
		 else if(x > 215 && x < 315) begin
			sprite_val = game_state[2][1];
			offset_x = 10'd215;
		 end
		 else if(x > 325 && x < 425) begin
			sprite_val = game_state[2][2];
			offset_x = 10'd325;
		 end
		 else if(x > 435 && x < 535) begin
			sprite_val = game_state[2][3];
			offset_x = 10'd435;
		 end
    end
	 
	 //cuarta fila
    else if(y>355 && y<455) begin
		 offset_y = 10'd355;
		 if(x > 105 && x<205) begin
			sprite_val = game_state[3][0];
			offset_x = 10'd105;
		 end
		 else if(x > 215 && x < 315) begin
			sprite_val = game_state[3][1];
			offset_x = 10'd215;
		 end
		 else if(x > 325 && x < 425) begin
			sprite_val = game_state[3][2];
			offset_x = 10'd325;
		 end
		 else if(x > 435 && x < 535) begin
			sprite_val = game_state[3][3];
			offset_x = 10'd435;
		 end
    end
	 
	 
	 else
		is_sprite = 1'b0;
end

wire [17:0] sprite_offset;

always_comb begin
	if(is_sprite == 1'b1) begin
	case(sprite_val)
	   12'd2    : rgb_color = 24'hfff0a6;
		12'd4    : rgb_color = 24'hfae05f;
		12'd8    : rgb_color = 24'hf7d00a;
		12'd16   : rgb_color = 24'hcafa6b;
		12'd32   : rgb_color = 24'ha8f50f;
		12'd64   : rgb_color = 24'h55ff4d;
		12'd128  : rgb_color = 24'h7cf7b7;
		12'd256  : rgb_color = 24'h19f784;
		12'd512  : rgb_color = 24'h6bbef2;
		12'd1024 : rgb_color = 24'h039cfc;
		12'd2048 : rgb_color = 24'hcc00ff;
		default: rgb_color = sprites::sprite_bg;
		
		/*
		12'd2    : sprite_offset =0000;
		12'd4    : sprite_offset =1000;
		12'd8    : sprite_offset =2000;
		12'd16   : sprite_offset =3000;
		12'd32   : sprite_offset =4000;
		12'd64   : sprite_offset =5000;
		12'd128  : sprite_offset =6000;
		12'd256  : sprite_offset =7000;
		12'd512  : sprite_offset =8000;
		12'd1024 : sprite_offset =9000;
		12'd2048 : sprite_offset =10000;
		default: sprite_offset = 0000;
	endcase
		rgb_color = sprite_sheet[sprite_offset + x-offset_x + 100*(y-offset_y)];*/
	endcase 
	end
	else 
		rgb_color = sprites::color_bg;
end
endmodule
