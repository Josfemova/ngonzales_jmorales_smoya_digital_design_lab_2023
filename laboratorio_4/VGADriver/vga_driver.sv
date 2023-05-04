`timescale 1ns / 1ps

module vga_driver(
    input clk_50MHz,   // clock de la fpga
    input reset,        // reset
    output video_on,    // area de display
    output hsync,       // sincronizacion horizontal
    output vsync,       // sincronizacion vertical
    output p_tick,      // clock de vga
    output [9:0] x,     // posicion x del pixel, 0-799
    output [9:0] y      // posicion y del pixel, 0-524
    );
	 
    // Limites horizontales Total = 800 pixels
    parameter HD = 640;             // horizontal display area width in pixels
    parameter HF = 48;              // horizontal front porch width in pixels
    parameter HB = 16;              // horizontal back porch width in pixels
    parameter HR = 96;              // horizontal retrace width in pixels
    parameter HMAX = HD+HF+HB+HR-1; // max value of horizontal counter = 799
    // Limites verticales Total = 525 pixels
    parameter VD = 480;             // vertical display area length in pixels 
    parameter VF = 10;              // vertical front porch length in pixels  
    parameter VB = 33;              // vertical back porch length in pixels   
    parameter VR = 2;               // vertical retrace length in pixels  
    parameter VMAX = VD+VF+VB+VR-1; // max value of vertical counter = 524   

    // -------------------------------
    wire vga_clk;
	 
	 // 25MHz clock
	 clock_div #(.DIV(2)) divider(.clk_in(clk_50MHz), .clk_out(vga_clk));
    
    reg [9:0] h_count_reg, h_count_next;
    reg [9:0] v_count_reg, v_count_next;
    
   
    reg v_sync_reg, h_sync_reg;
    wire v_sync_next, h_sync_next;
    
  
    always @(posedge clk_50MHz or posedge reset)
        if(reset) begin
            v_count_reg <= 0;
            h_count_reg <= 0;
            v_sync_reg  <= 1'b0;
            h_sync_reg  <= 1'b0;
        end
        else begin
            v_count_reg <= v_count_next;
            h_count_reg <= h_count_next;
            v_sync_reg  <= v_sync_next;
            h_sync_reg  <= h_sync_next;
        end
         
    //Contador horizontal
    //always @(posedge w_25MHz or posedge reset)    
	 always @(posedge vga_clk or posedge reset) begin   	 
        if(reset)
            h_count_next <= 0;
        else
            if(h_count_reg == HMAX)                 
                h_count_next <= 0;
            else
                h_count_next <= h_count_reg + 1;         
  
    // Contador vertical
        if(reset)
            v_count_next = 0;
        else
            if(h_count_reg == HMAX)                
                if((v_count_reg == VMAX))           
                    v_count_next <= 0;
                else
                    v_count_next <= v_count_reg + 1;
		end
        
    
    assign h_sync_next = (h_count_reg >= (HD+HB) && h_count_reg <= (HD+HB+HR-1));
    
    
    assign v_sync_next = (v_count_reg >= (VD+VB) && v_count_reg <= (VD+VB+VR-1));
    
    // Cuando los pixeles estan en el area del display
    assign video_on = (h_count_reg < HD) && (v_count_reg < VD); // 0-639 and 0-479 respectively
            
   
    assign hsync  = h_sync_reg;
    assign vsync  = v_sync_reg;
    assign x      = h_count_reg;
    assign y      = v_count_reg;
    assign p_tick = vga_clk;//w_25MHz;
            
endmodule