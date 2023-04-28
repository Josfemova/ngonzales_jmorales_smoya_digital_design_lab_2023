`timescale 1ns / 1ps

module vga_top(
	input clk_50MHz,      
	input reset,
	input [23:0] sw,       
	output hsync, 
	output vsync,
	output [23:0] rgb,      
	output p_tick,
	output [9:0] x,     
	output [9:0] y 
);
	
	
	reg [23:0] rgb_reg;    
	wire video_on;         

    
    vga_driver vga_c(.clk_50MHz(clk_50MHz), .reset(reset), .hsync(hsync), .vsync(vsync),
                         .video_on(video_on), .p_tick(p_tick), .x(x), .y(y));
    
    always @(posedge clk_50MHz or posedge reset)
    if (reset)
       rgb_reg <= 0;
    else
		if(x<200)
		begin
			if(y<90)
			rgb_reg <= 24'b001000000000000011111111;
			else if((y>=90)&&(y<180))
				rgb_reg <= 24'b111111111111111111111111;
			else if((y>=180)&&(y<300))
				rgb_reg <= 24'b111111110000000000000000;
			else if((y>=300)&&(y<390))
				rgb_reg <= 24'b111111111111111111111111;
			else
				rgb_reg <= 24'b001000000000000011111111;
		end
		else
			rgb_reg <= 24'b001000001111111100000000;
    
   
    assign rgb = (video_on) ? rgb_reg : 24'b0;   // while in display area RGB color = sw, else all OFF
        
endmodule