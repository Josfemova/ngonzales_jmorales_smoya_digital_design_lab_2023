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
		if(x>100)
			rgb_reg <= 24'b001000000000000011111111;
		else
			rgb_reg <= 24'b111100000000000011110000;
    
   
    assign rgb = (video_on) ? rgb_reg : 24'b0;   // while in display area RGB color = sw, else all OFF
        
endmodule