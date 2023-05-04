module top (
input logic rst,clk, btn_izq,btn_der,btn_up,btn_down,win,lose, start, fin,
input logic [11:0] matriz_in [0:3][0:3],
output logic [3:0] estado,
output logic [2:0] mov,
output logic [11:0] matriz [0:3][0:3]
);

logic [11:0] matriz_in_aux [0:3][0:3] = '{default:0};


initial begin
	matriz_in_aux [0][3] <= 12'b00000000010;
	matriz_in_aux [0][2] <= 12'b00000000010;
	matriz_in_aux [1][3] <= 12'b00000000100;
	matriz_in_aux [2][2] <= 12'b00000001000;

end

maquina_estados maq(rst,clk, btn_izq,btn_der,btn_up,btn_down,win,lose, start, fin,estado, mov);

juego juego(estado,mov, matriz_in_aux,matriz);

always @(estado)
begin
	if(estado == 4'b1001 || estado == 4'b1010 || estado == 1011)
	begin
	  matriz_in_aux = matriz;
	end
end



endmodule