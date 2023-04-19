module top (
input logic rst,clk, btn_izq,btn_der,btn_up,btn_down,win,loose,check, start, fin,
output logic [3:0] estado_act
);

maquina_estados maq(rst,clk, btn_izq,btn_der,btn_up,btn_down,win,loose,check, start, fin,estado_act);




endmodule