module xvga_driver(
    input vga_clk,   // clock de la fpga
    input reset,        // reset
    output video_on,    // area de display
    output reg hsync,       // sincronizacion horizontal
    output reg vsync,       // sincronizacion vertical
    output p_tick,      // clock de vga
    output reg [9:0] x,     // posicion x del pixel, 0-799
    output reg [9:0] y,      // posicion y del pixel, 0-524
	 output sync, 
	 output blank
    );
	 
    // Limites horizontales Total = 800 pixels
    parameter HD = 640;             // horizontal display area width in pixels
    parameter HF = 16;              // horizontal front porch width in pixels
    parameter HB = 48;              // horizontal back porch width in pixels
    parameter HP = 96;              // horizontal pulse width in pixels
    parameter HMAX = HD+HF+HB+HP-1; // max value of horizontal counter = 799
    // Limites verticales Total = 525 pixels
    parameter VD = 480;             // vertical display area length in pixels 
    parameter VF = 10;              // vertical front porch length in pixels  
    parameter VB = 33;              // vertical back porch length in pixels   
    parameter VP = 2;               // vertical pulse length in pixels  
    parameter VMAX = VD+VF+VB+VP-1; // max value of vertical counter = 524   

    // -------------------------------

	 always @(posedge vga_clk) begin   	 
        if(reset) begin
            x <= 0;
				y <= 0;
				hsync <= 0;
				vsync <= 0;
        end else
				//Contador horizontal
            if(x == HMAX) begin               
                x <= 0;
					 // contador vertical
					 if((y == VMAX))           
                    y <= 0;
                else
                    y <= y + 1;
            end else
                x <= x + 1;         
						  
				// sync solo es low en pulse
				hsync <= ~ ((x >= HD + HF) && (x <= HD+HF+HP));
				vsync <= ~ ((y >= VD + VF) && (y <= VD+VF+VP));
		end
		
    assign video_on = (x < HD) && (y < VD); // ambas coords se encuentran en area activa
	 assign sync = 1'b_0 ;
    assign blank = hsync & vsync;
    assign p_tick = vga_clk;
            
endmodule