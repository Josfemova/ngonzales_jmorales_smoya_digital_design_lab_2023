module top (
input logic rst,clk, btn_izq,btn_der,btn_up,btn_down,win,loose,check, start, fin,
output logic [3:0] estado_act,
output logic [3:0] i, i_1, j, j_1
);

maquina_estados maq(rst,clk, btn_izq,btn_der,btn_up,btn_down,win,loose,check, start, fin,estado_act,i, i_1, j, j_1);




endmodule