module juego_tb;
logic [11:0] score;
logic [1:0] draw_state;
logic clk = 0;
logic reset = 1;
logic [3:0]meta = 3;
logic [3:0] dir = 4'b0;
logic [3:0] gmatrix[0:3][0:3] = '{default:0}; // valor por casilla es potencia de 2

always #2 clk = ~clk;

juego_neo jg(
    .clk(clk), 
	 .reset(reset), 
    .goal(meta),
    .dir(dir),
    .gmatrix(gmatrix),
    .score(score),
	.draw_state(draw_state)
);

initial begin
	#4
	reset = 0;
	dir = 4'b0001;//mov a la izquierda
	#10
	dir = 4'b0010; //Mov a arriba
	#10
	dir = 4'b1000; //Mov a la derecha
	#10
	dir = 4'b0100; // Mov a abajo
	#10
	dir = 4'b0000; //No hay movimiento
	#10
	dir = 4'b0100; //Mov a abajo
	#10
	dir = 4'b0100; // mov a abajo
	#10
	reset =1;    // reset del juego 
end

endmodule