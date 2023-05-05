module top #(parameter GOAL = 2048)(
input logic rst,clk, btn_izq,btn_der,btn_up,btn_down, start, fin,
input logic [11:0] matriz_in [0:3][0:3],
output logic [3:0] estado,
output logic [2:0] mov,
output logic [11:0] matriz [0:3][0:3]
);

logic [11:0] matriz_in_aux [0:3][0:3] = '{default:0};
//logic win,lose =0;


initial begin
	matriz_in_aux [0][3] <= 12'b00000000010;
	matriz_in_aux [0][2] <= 12'b00000000010;
	matriz_in_aux [1][3] <= 12'b00000000010;
	matriz_in_aux [2][2] <= 12'b00000001000;

end

maquina_estados maq(rst,clk, btn_izq,btn_der,btn_up,btn_down,win,lose, start, fin,estado, mov);

juego juego(estado,mov, matriz_in_aux,matriz);


assign lose = ((matriz[0][0] !== matriz[0][1]) && (matriz[0][0] !== matriz[1][0]) && (matriz[0][1] !== matriz[1][1]) && (matriz[0][1] !== matriz[0][2]) &&(matriz[0][2] !== matriz[1][3]) &&
	(matriz[0][2] !== matriz[0][3]) && (matriz[0][3] !== matriz[1][3]) && (matriz[1][0] !== matriz[1][1]) && (matriz[1][0] !== matriz[2][0]) && (matriz[1][1] !== matriz[1][2]) && 
	(matriz[1][1] !== matriz[2][1]) && (matriz[1][2] !== matriz[1][3]) && (matriz[1][2] !== matriz[2][2]) && (matriz[1][3] !== matriz[2][3]) && (matriz[2][0] !== matriz[2][1]) && 
	(matriz[2][0] !== matriz[3][0]) && (matriz[2][1] !== matriz[2][2]) && (matriz[2][1] !== matriz[3][1]) && (matriz[2][2] !== matriz[2][3]) && (matriz[2][2] !== matriz[3][2]) && 
	(matriz[2][3] !== matriz[3][3]) && (matriz[3][0] !== matriz[3][1]) && (matriz[3][1] !== matriz[3][2]) && (matriz[3][2] !== matriz[3][3])&&(matriz[0][0] !== 0)&&
	(matriz[0][1] !== 0)&&(matriz[0][2] !== 0)&&(matriz[0][3] !== 0)&&(matriz[1][0] !== 0)&&(matriz[1][1] !== 0)
	&&(matriz[1][2] !== 0)&&(matriz[1][3] !== 0)&&(matriz[2][0] !== 0)&&(matriz[2][1] !== 0)&&(matriz[2][2] !== 0)
	&&(matriz[2][3] !== 0)&&(matriz[3][0] !== 0)&&(matriz[3][1] !== 0)&&(matriz[3][2] !== 0)&&(matriz[3][3] !== 0));

assign win = ((matriz[0][0] == GOAL) || (matriz[0][1] == GOAL) || (matriz[0][2] == GOAL) || (matriz[0][3] == GOAL) || (matriz[1][0] == GOAL) || (matriz[1][1] == GOAL) || (matriz[1][2] == GOAL) || (matriz[1][3] == GOAL) || 
(matriz[2][0] == GOAL) || (matriz[2][1] == GOAL) || (matriz[2][2] == GOAL) || (matriz[2][3] == GOAL) || (matriz[3][0] == GOAL) || (matriz[3][1] == GOAL) || (matriz[3][2] == GOAL) || (matriz[3][3] == GOAL));



always @(estado)
begin
	if(estado == 4'b1001 || estado == 4'b1010 || estado == 4'b1011)
	begin
	  matriz_in_aux = matriz;
	end
end



endmodule