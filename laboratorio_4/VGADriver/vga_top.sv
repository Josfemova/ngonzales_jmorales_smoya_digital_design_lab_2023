`timescale 1ns / 1ps

module vga_top(
	input clk_50MHz,      
	input reset,
	input [23:0] sw,       
	output hsync, 
	output vsync,
	output [23:0] rgb,      
	output p_tick,
	output sync,
	output blank
);
	

	wire video_on;

	
	wire [23:0] rgb_reg;    
	reg [9:0] cx = 0;
	reg [9:0] cy = 0;
	reg [9:0] nx, ny;
	reg toggle = 1'b0;
	reg [11:0] game_state[3:0][3:0];

	 wire misc_clk, vga_clk,ssa, locked;
	 // 25MHz clock
	 pll_25 (clk_50MHz, reset, ssa, locked);
	 clock_div #(.DIV(25000000)) divider(.clk_in(ssa), .clk_out(misc_clk));
	 //assign vga_clk = rvga_clk;
	 clock_div #(.DIV(2)) divider2(.clk_in(clk_50MHz), .clk_out(vga_clk));
	 //pll_25 (clk_50MHz, ~reset, vga_clock, locked);
	 
	 always @(posedge misc_clk) begin
		if(toggle == 1'b0) 
			game_state <= '{'{2,4,8,16}, '{32,2048,1024,512}, '{256,128,64,32}, '{16,8,4,2}};
		else
			game_state <= '{'{0,4,0,16}, '{32,2,4,2}, '{8,16,4,2}, '{1024,8,4,2}};
			
		toggle <= ~toggle;
	 end
	 
    
    xvga_driver vga_c(.vga_clk(vga_clk), .reset(reset), .hsync(hsync), .vsync(vsync),
                        .video_on(video_on), .p_tick(p_tick), .x(nx), .y(ny), .sync(sync), .blank(blank));
	 
	 screen_drawer sd(
		 .x(cx),
		 .y(cy),
		 .game_state(game_state),
		 .rgb_color(rgb_reg)
	 );
    
    always @(posedge clk_50MHz or posedge reset) begin
		if (reset) begin
			//rgb_reg <= 0;
			cx <= 0;
			cy <= 0;
		end else begin
			cx <= nx;
			cy <= ny;
		end
	 end
	 
    assign rgb = (video_on) ? rgb_reg : 24'b0;   // while in display area RGB color = sw, else all OFF
        
endmodule