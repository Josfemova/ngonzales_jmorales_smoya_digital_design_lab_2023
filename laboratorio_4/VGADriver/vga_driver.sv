module vga_driver(
    input clk,   				// clock 25Mhz
    input reset,        	// reset
    output video_on,    	// area de display
    output reg hsync,      // sincronizacion horizontal
    output reg vsync,      // sincronizacion vertical
    output reg [9:0] x,    // posicion x del pixel, 0-799
    output reg [9:0] y,    // posicion y del pixel, 0-524
	 output sync, 				// sync simultaneo
	 output blank	//señal de blank de dac VGA
    );
	 
    // Limites horizontales (en cuenta de pixeles). Total = 800 pixels
    parameter H_DISPLAY = 640;            
    parameter H_FRONT_PORCH = 16; 
    parameter H_BACK_PORCH = 48;       
    parameter H_PULSE = 96;             
    parameter HMAX = H_DISPLAY+H_FRONT_PORCH+H_BACK_PORCH+H_PULSE-1; // max val = 799
    // Limites verticales (en cuenta de pixeles). Total = 525 pixels
    parameter V_DISPLAY = 480;              
    parameter V_FRONT_PORCH = 10;            
    parameter V_BACK_PORCH = 33;       
    parameter V_PULSE = 2;      
    parameter VMAX = V_DISPLAY+V_FRONT_PORCH+V_BACK_PORCH+V_PULSE-1; // max val = 524   

    // -------------------------------

	 always @(posedge clk) begin   	 
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
				hsync <= ~ ((x >= H_DISPLAY + H_FRONT_PORCH) && (x <= H_DISPLAY+H_FRONT_PORCH+H_PULSE));
				vsync <= ~ ((y >= V_DISPLAY + V_FRONT_PORCH) && (y <= V_DISPLAY+V_FRONT_PORCH+V_PULSE));
		end
		
    assign video_on = (x < H_DISPLAY) && (y < V_DISPLAY); // ambas coords se encuentran en area activa
	 assign sync = 1'b_0 ;
    assign blank = hsync & vsync;
            
endmodule