module unir(
input logic [3:0] mov, estado,
input logic i, i_1, j, j_1,
input logic clk,
output logic [11:0] matriz [3:0][3:0],
output logic checked
);

always @(posedge clk)
begin
	if(estado == 4'b1000)
	begin
		if (mov == 4'b0100) // se activa la unión a la izquierda
		begin
			if(i <= 4)
			begin
				checked <= 1;
			end
			else
			begin
				//fila 1
				if(matriz[0][i_1] == 0 || matriz[0][i] == matriz[0][i_1])
				begin
					matriz[0][i_1] <= matriz[0][i_1] + matriz[0][i];
					matriz[0][i] <= 0;
				end
				//fila 2
				if(matriz[1][i_1] == 0 || matriz[1][i] == matriz[1][i_1])
				begin
					matriz[1][i_1] <= matriz[1][i_1] + matriz[1][i];
					matriz[1][i] <= 0;
				end
				//fila 3
				if(matriz[2][i_1] == 0 || matriz[2][i] == matriz[2][i_1])
				begin
					matriz[2][i_1] <= matriz[2][i_1] + matriz[2][i];
					matriz[2][i] <= 0;
				end
				//fila 4
				if(matriz[3][i_1] == 0 || matriz[3][i] == matriz[3][i_1])
				begin
					matriz[3][i_1] <= matriz[3][i_1] + matriz[3][i];
					matriz[3][i] <= 0;
				end
			end
		end
		if (mov == 4'b0011) // se activa la unión a la derecha
		begin
			if(i < 0)
			begin
				checked <= 1;
			end
			else
			begin
				//fila 1
				if(matriz[0][i] == 0 || matriz [0][i] == matriz [0][i_1])
				begin
					matriz[0][i] <= matriz[0][i_1] + matriz[0][i];
					matriz[0][i_1] <= 0;
				end
				//fila 2
				if(matriz[1][i] == 0|| matriz [1][i] == matriz [1][i_1])
				begin
					matriz[1][i] <= matriz[1][i_1] + matriz[1][i];
					matriz[1][i_1] <= 0;
				end
				//fila 3
				if(matriz[2][i] == 0 || matriz [2][i] == matriz [2][i_1])
				begin
					matriz[2][i] <= matriz[2][i_1] + matriz[2][i];
					matriz[2][i_1] <= 0;
				end
				//fila 4
				if(matriz[3][i] == 0 || matriz [3][i] == matriz [3][i_1])
				begin
					matriz[3][i] <= matriz[3][i_1] + matriz[3][i];
					matriz[3][i_1] <= 0;
				end
			end
		end
		if (mov == 4'b0101) // se activa la unión hacia arriba
		begin
			if(i <= 4)
			begin
				checked <= 1;
			end
			else
			begin
				//Col 1
				if(matriz[i_1][0] == 0 || matriz[i_1][0] == matriz[i][0])
				begin
					matriz[i_1][0] <= matriz[i_1][0] + matriz[i][0];
					matriz[i][0] <= 0;
				end
				//Col 2
				if(matriz[i_1][1] == 0 || matriz[i_1][1] == matriz[i][1])
				begin
					matriz[i_1][1] <= matriz[i_1][1] + matriz[i][1];
					matriz[i][1] <= 0;
				end
				//Col 3
				if(matriz[i_1][2] == 0 || matriz[i_1][2] == matriz[i][2])
				begin
					matriz[i_1][2] <= matriz[i_1][2] + matriz[i][2];
					matriz[i][2] <= 0;
				end
				//Col 4
				if(matriz[i_1][3] == 0 || matriz[i_1][3] == matriz[i][3])
				begin
					matriz[i_1][3] <= matriz[i_1][3] + matriz[i][3];
					matriz[i][3] <= 0;
				end
			end
		end
		if (mov == 4'b0110) // se activa la unión hacia abajo
		begin
			if(i == 4)
			begin
				checked <= 1;
			end
			else
			begin
				//Col 1
				if(matriz[i][0] == 0 || matriz[i_1][0] == matriz[i][0])
				begin
					matriz[i][0] <= matriz[i_1][0] + matriz[i][0];
					matriz[i_1][0] <= 0;
				end
				//Col 2
				if(matriz[i][1] == 0 || matriz[i_1][1] == matriz[i][1])
				begin
					matriz[i][1] <= matriz[i_1][1] + matriz[i][1];
					matriz[i_1][1] <= 0;
				end
				//Col 3
				if(matriz[i][2] == 0 || matriz[i_1][2] == matriz[i][2])
				begin
					matriz[i][2] <= matriz[i_1][2] + matriz[i][2];
					matriz[i_1][2] <= 0;
				end
				//Col 4
				if(matriz[i][3] == 0 || matriz[i_1][3] == matriz[i][3])
				begin
					matriz[i][3] <= matriz[i_1][3] + matriz[i][3];
					matriz[i_1][3] <= 0;
				end
			end
		end
	end
end

endmodule 

