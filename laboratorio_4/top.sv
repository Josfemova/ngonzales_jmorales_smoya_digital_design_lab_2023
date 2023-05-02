module top (
input logic rst,clk, btn_izq,btn_der,btn_up,btn_down,win,lose, start, fin,
input logic [11:0] matriz_in [0:3][0:3],
output logic [3:0] estado_act,
output logic [2:0] mov,
output logic [11:0] matriz [0:3][0:3]
);

//unir un_(estado,mov, matriz_in,matriz);

maquina_estados maq(rst,clk, btn_izq,btn_der,btn_up,btn_down,win,lose, start, fin,estado_act, mov);

//mover_izquierda mov_izq(estado_act, mov, matriz_in, matriz);

//mover_derecha mov_der(estado_act, mov, matriz_in, matriz);

mover_arriba mov_up(estado_act, mov, matriz_in, matriz);

//mover_abajo mov_down(estado_act, mov, matriz_in, matriz);


endmodule