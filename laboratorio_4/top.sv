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


/*assign win = ((matriz[0] !== matriz[1]) && (matriz[0] !== matriz[4]) && (matriz[1] !== matriz[5]) && (matriz[1] !== matriz[2]) &&(matriz[2] !== matriz[6]) &&
	(matriz[2] !== matriz[3]) && (matriz[3] !== matriz[7]) && (matriz[4] !== matriz[5]) && (matriz[4] !== matriz[8]) && (matriz[5] !== matriz[9]) && 
	(matriz[5] !== matriz[6]) && (matriz[6] !== matriz[7]) && (matriz[6] !== matriz[10]) && (matriz[7] !== matriz[11]) && (matriz[8] !== matriz[9]) && 
	(matriz[8] !== matriz[12]) && (matriz[9] !== matriz[10]) && (matriz[9] !== matriz[13]) && (matriz[10] !== matriz[14]) && (matriz[10] !== matriz[11]) && 
	(matriz[11] !== matriz[15]) && (matriz[12] !== matriz[13]) && (matriz[13] !== matriz[14]) && (matriz[14] !== matriz[15])&&(matriz[0] !== 0)&&
	(matriz[1] !== 0)&&(matriz[2] !== 0)&&(matriz[3] !== 0)&&(matriz[4] !== 0)&&(matriz[5] !== 0)
	&&(matriz[6] !== 0)&&(matriz[7] !== 0)&&(matriz[8] !== 0)&&(matriz[9] !== 0)&&(matriz[10] !== 0)
	&&(matriz[11] !== 0)&&(matriz[12] !== 0)&&(matriz[13] !== 0)&&(matriz[14] !== 0)&&(matriz[15] !== 0));

assign lose = ((matriz[0] == 256) || (matriz[1] == 256) || (matriz[2] == 256) || (matriz[3] == 256) || (matriz[4] == 256) || (matriz[5] == 256) || (matriz[6] == 256) || (matriz[7] == 256) || 
(matriz[8] == 256) || (matriz[9] == 256) || (matriz[10] == 256) || (matriz[11] == 256) || (matriz[12] == 256) || (matriz[13] == 256) || (matriz[14] == 256) || (matriz[15] == 256));
*/


always @(estado)
begin
	if(estado == 4'b1001 || estado == 4'b1010 || estado == 1011)
	begin
	  matriz_in_aux = matriz;
	end
end



endmodule