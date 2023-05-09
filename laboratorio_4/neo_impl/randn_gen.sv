/*
 No genera números random como tal, sin embargo, dado que el valor se 
 toma solo ante un input del usuario en un momento desconocido, ya el usuario
 introduce el elemento aleatorio a la generación
*/
module randn_gen #(parameter WIDTH=4, OPTIONS=2) (
    input clk, reset,
    input [WIDTH-1:0] options[OPTIONS-1:0],
    output [WIDTH-1:0] number
);

reg [OPTIONS-1:0] sel = 0;

always @(posedge clk) begin
    if (reset)
        sel <= 0;
    else if (sel < (OPTIONS-1)) begin 
        sel <= sel+1;
    end else begin 
        sel <= 0;
    end
end 

assign number = options[sel];


endmodule