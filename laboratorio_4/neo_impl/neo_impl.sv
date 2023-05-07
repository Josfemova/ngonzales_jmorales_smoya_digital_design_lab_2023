module neo_impl(input clk, input reset, input [3:0] dir, output [3:0] gmatrix[0:3][0:3]);

//wire [3:0] gmatrix[0:3][0:3]; // valor por casilla es potencia de 2
wire [3:0] state;

juego_neo jg(
    .clk(lk), .reset(reset), 
    .goal(1024),
    .dir(dir),
    .gmatrix(gmatrix), // valor por casilla es potencia de 2
    .state(state)
);

endmodule