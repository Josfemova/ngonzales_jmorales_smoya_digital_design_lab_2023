module proyecto_final(
	input clk_50MHz,      
	input reset,
	
	//señales VGA
	output hsync, 
	output vsync,
	output [7:0] rgb_r,
	output [7:0] rgb_g,
	output [7:0] rgb_b,	
	output clk_vga,
	output sync,
	output blank
);

clock_div #(.DIV(2)) divider2(.clk_in(clk_50MHz), .clk_out(clk_25MHz));
assign clk_vga = clk_25MHz;


//graficos

wire video_on;
wire [23:0] rgb_w;    
reg [9:0] current_x = 0;
reg [9:0] current_y = 0;
reg [9:0] next_x, next_y;

vga_driver vga_inst(
		.clk(clk_25MHz), 
		.reset(reset), 
		.hsync(hsync), 
		.vsync(vsync),
		.video_on(video_on), 
		.x(next_x), 
		.y(next_y), 
		.sync(sync), 
		.blank(blank));
 
 /*screen_drawer sd(
	 .x(current_x),
	 .y(current_y),
	 .draw_state(draw_state),
	 .rgb_color(rgb_w)
 );*/
assign rgb_color = 24'hff00ff;
always @(posedge clk_25MHz or posedge reset) begin
	if (reset) begin
		current_x <= 0;
		current_y <= 0;
	end else begin
		current_x <= next_x;
		current_y <= next_y;
	end
 end
 
assign rgb_r = (video_on) ? rgb_w[23:16] : 8'b0; 
assign rgb_g = (video_on) ? rgb_w[15:8] : 8'b0; 
assign rgb_b = (video_on) ? rgb_w[7:0] : 8'b0; 


endmodule
