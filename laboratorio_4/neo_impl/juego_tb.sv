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
	reset = 0; // se utiliza una meta de 4 y se pruebas todos los movimientos y la condicion de ganar
	dir[3] = 1;
	#50
	dir[3] = 0;
	#50
	dir[1] = 1;
	#50
	dir[1] = 0;
	#50
	dir[2] = 1;
	#50
	dir[2] = 0;
	#50
	dir[3] = 1;
	#50
	dir[3] = 0;
	#50
	dir[0] = 1;
	#50
	dir[0] = 0;
	#50
	dir[3] = 1;
	#50
	dir[3] = 0;
	#50
	dir[1] = 1;
	#50
	dir[1] = 0;
	#50
	dir[2] = 1;
	#50
	dir[2] = 0;
	#50
	dir[3] = 1;
	#50
	dir[3] = 0;
	#50
	dir[0] = 1;
	#50
	dir[0] = 0;
	
	#100
	reset =1;
	#4
	reset = 0;	// reset del juego 
	meta = 11; // se cambia la meta a 2048 y se hacen movimientos aleatorios para probar la condicion de perder
	dir[3] = 1;
	#50
	dir[3] = 0;
	#50
	dir[1] = 1;
	#50
	dir[1] = 0;
	#50
	dir[2] = 1;
	#50
	dir[2] = 0;
	#50
	dir[3] = 1;
	#50
	dir[3] = 0;
	#50
	dir[0] = 1;
	#50
	dir[0] = 0;
	#50
	dir[3] = 1;
	#50
	dir[3] = 0;
	#50
	dir[1] = 1;
	#50
	dir[1] = 0;
	#50
	dir[2] = 1;
	#50
	dir[2] = 0;
	#50
	dir[3] = 1;
	#50
	dir[3] = 0;
	#50
	dir[0] = 1;
	#50
	dir[0] = 0;
	dir[3] = 1;
	#50
	dir[3] = 0;
	#50
	dir[1] = 1;
	#50
	dir[1] = 0;
	#50
	dir[2] = 1;
	#50
	dir[2] = 0;
	#50
	dir[3] = 1;
	#50
	dir[3] = 0;
	#50
	dir[0] = 1;
	#50
	dir[0] = 0;
	#50
	dir[3] = 1;
	#50
	dir[3] = 0;
	#50
	dir[1] = 1;
	#50
	dir[1] = 0;
	#50
	dir[2] = 1;
	#50
	dir[2] = 0;
	#50
	dir[3] = 1;
	#50
	dir[3] = 0;
	#50
	dir[0] = 1;
	#50
	dir[0] = 0;
	dir[3] = 1;
	#50
	dir[3] = 0;
	#50
	dir[1] = 1;
	#50
	dir[1] = 0;
	#50
	dir[2] = 1;
	#50
	dir[2] = 0;
	#50
	dir[3] = 1;
	#50
	dir[3] = 0;
	#50
	dir[0] = 1;
	#50
	dir[0] = 0;
	#50
	dir[3] = 1;
	#50
	dir[3] = 0;
	#50
	dir[1] = 1;
	#50
	dir[1] = 0;
	#50
	dir[2] = 1;
	#50
	dir[2] = 0;
	#50
	dir[3] = 1;
	#50
	dir[3] = 0;
	#50
	dir[0] = 1;
	#50
	dir[0] = 0;
	dir[3] = 1;
	#50
	dir[3] = 0;
	#50
	dir[1] = 1;
	#50
	dir[1] = 0;
	#50
	dir[2] = 1;
	#50
	dir[2] = 0;
	#50
	dir[3] = 1;
	#50
	dir[3] = 0;
	#50
	dir[0] = 1;
	#50
	dir[0] = 0;
	#50
	dir[3] = 1;
	#50
	dir[3] = 0;
	#50
	dir[1] = 1;
	#50
	dir[1] = 0;
	#50
	dir[2] = 1;
	#50
	dir[2] = 0;
	#50
	dir[3] = 1;
	#50
	dir[3] = 0;
	#50
	dir[0] = 1;
	#50
	dir[0] = 0;
	dir[3] = 1;
	#50
	dir[3] = 0;
	#50
	dir[1] = 1;
	#50
	dir[1] = 0;
	#50
	dir[2] = 1;
	#50
	dir[2] = 0;
	#50
	dir[3] = 1;
	#50
	dir[3] = 0;
	#50
	dir[0] = 1;
	#50
	dir[0] = 0;
	#50
	dir[3] = 1;
	#50
	dir[3] = 0;
	#50
	dir[1] = 1;
	#50
	dir[1] = 0;
	#50
	dir[2] = 1;
	#50
	dir[2] = 0;
	#50
	dir[3] = 1;
	#50
	dir[3] = 0;
	#50
	dir[0] = 1;
	#50
	dir[0] = 0;
	#50
	dir[3] = 1;
	#50
	dir[3] = 0;
	#50
	dir[1] = 1;
	#50
	dir[1] = 0;
	#50
	dir[2] = 1;
	#50
	dir[2] = 0;
	#50
	dir[3] = 1;
	#50
	dir[3] = 0;
	#50
	dir[0] = 1;
	#50
	dir[0] = 0;
	#50
	dir[3] = 1;
	#50
	dir[3] = 0;
	#50
	dir[1] = 1;
	#50
	dir[1] = 0;
	#50
	dir[2] = 1;
	#50
	dir[2] = 0;
	#50
	dir[3] = 1;
	#50
	dir[3] = 0;
	#50
	dir[0] = 1;
	#50
	dir[0] = 0;
	dir[3] = 1;
	#50
	dir[3] = 0;
	#50
	dir[1] = 1;
	#50
	dir[1] = 0;
	#50
	dir[2] = 1;
	#50
	dir[2] = 0;
	#50
	dir[3] = 1;
	#50
	dir[3] = 0;
	#50
	dir[0] = 1;
	#50
	dir[0] = 0;
	#50
	dir[3] = 1;
	#50
	dir[3] = 0;
	#50
	dir[1] = 1;
	#50
	dir[1] = 0;
	#50
	dir[2] = 1;
	#50
	dir[2] = 0;
	#50
	dir[3] = 1;
	#50
	dir[3] = 0;
	#50
	dir[0] = 1;
	#50
	dir[0] = 0;
	#50
	dir[3] = 1;
	#50
	dir[3] = 0;
	#50
	dir[1] = 1;
	#50
	dir[1] = 0;
	#50
	dir[2] = 1;
	#50
	dir[2] = 0;
	#50
	dir[3] = 1;
	#50
	dir[3] = 0;
	#50
	dir[0] = 1;
	#50
	dir[0] = 0;
	#50
	dir[3] = 1;
	#50
	dir[3] = 0;
	#50
	dir[1] = 1;
	#50
	dir[1] = 0;
	#50
	dir[2] = 1;
	#50
	dir[2] = 0;
	#50
	dir[3] = 1;
	#50
	dir[3] = 0;
	#50
	dir[0] = 1;
	#50
	dir[0] = 0;
	dir[3] = 1;
	#50
	dir[3] = 0;
	#50
	dir[1] = 1;
	#50
	dir[1] = 0;
	#50
	dir[2] = 1;
	#50
	dir[2] = 0;
	#50
	dir[3] = 1;
	#50
	dir[3] = 0;
	#50
	dir[0] = 1;
	#50
	dir[0] = 0;
	#50
	dir[3] = 1;
	#50
	dir[3] = 0;
	#50
	dir[1] = 1;
	#50
	dir[1] = 0;
	#50
	dir[2] = 1;
	#50
	dir[2] = 0;
	#50
	dir[3] = 1;
	#50
	dir[3] = 0;
	#50
	dir[0] = 1;
	#50
	dir[0] = 0;
	dir[3] = 1;
	#50
	dir[3] = 0;
	#50
	dir[1] = 1;
	#50
	dir[1] = 0;
	#50
	dir[2] = 1;
	#50
	dir[2] = 0;
	#50
	dir[3] = 1;
	#50
	dir[3] = 0;
	#50
	dir[0] = 1;
	#50
	dir[0] = 0;
	#50
	dir[3] = 1;
	#50
	dir[3] = 0;
	#50
	dir[1] = 1;
	#50
	dir[1] = 0;
	#50
	dir[2] = 1;
	#50
	dir[2] = 0;
	#50
	dir[3] = 1;
	#50
	dir[3] = 0;
	#50
	dir[0] = 1;
	#50
	dir[0] = 0;
	dir[3] = 1;
	#50
	dir[3] = 0;
	#50
	dir[1] = 1;
	#50
	dir[1] = 0;
	#50
	dir[2] = 1;
	#50
	dir[2] = 0;
	#50
	dir[3] = 1;
	#50
	dir[3] = 0;
	#50
	dir[0] = 1;
	#50
	dir[0] = 0;
	#50
	dir[3] = 1;
	#50
	dir[3] = 0;
	#50
	dir[1] = 1;
	#50
	dir[1] = 0;
	#50
	dir[2] = 1;
	#50
	dir[2] = 0;
	#50
	dir[3] = 1;
	#50
	dir[3] = 0;
	#50
	dir[0] = 1;
	#50
	dir[0] = 0;
	dir[3] = 1;
	#50
	dir[3] = 0;
	#50
	dir[1] = 1;
	#50
	dir[1] = 0;
	#50
	dir[2] = 1;
	#50
	dir[2] = 0;
	#50
	dir[3] = 1;
	#50
	dir[3] = 0;
	#50
	dir[0] = 1;
	#50
	dir[0] = 0;
	#50
	dir[3] = 1;
	#50
	dir[3] = 0;
	#50
	dir[1] = 1;
	#50
	dir[1] = 0;
	#50
	dir[2] = 1;
	#50
	dir[2] = 0;
	#50
	dir[3] = 1;
	#50
	dir[3] = 0;
	#50
	dir[0] = 1;
	#50
	dir[0] = 0;
	#50
	dir[3] = 1;
	#50
	dir[3] = 0;
	#50
	dir[1] = 1;
	#50
	dir[1] = 0;
	#50
	dir[2] = 1;
	#50
	dir[2] = 0;
	#50
	dir[3] = 1;
	#50
	dir[3] = 0;
	#50
	dir[0] = 1;
	#50
	dir[0] = 0;
	#50
	dir[3] = 1;
	#50
	dir[3] = 0;
	#50
	dir[1] = 1;
	#50
	dir[1] = 0;
	#50
	dir[2] = 1;
	#50
	dir[2] = 0;
	#50
	dir[3] = 1;
	#50
	dir[3] = 0;
	#50
	dir[0] = 1;
	#50
	dir[0] = 0;
	dir[3] = 1;
	#50
	dir[3] = 0;
	#50
	dir[1] = 1;
	#50
	dir[1] = 0;
	#50
	dir[2] = 1;
	#50
	dir[2] = 0;
	#50
	dir[3] = 1;
	#50
	dir[3] = 0;
	#50
	dir[0] = 1;
	#50
	dir[0] = 0;
	#50
	dir[3] = 1;
	#50
	dir[3] = 0;
	#50
	dir[1] = 1;
	#50
	dir[1] = 0;
	#50
	dir[2] = 1;
	#50
	dir[2] = 0;
	#50
	dir[3] = 1;
	#50
	dir[3] = 0;
	#50
	dir[0] = 1;
	#50
	dir[0] = 0;
	
end

endmodule