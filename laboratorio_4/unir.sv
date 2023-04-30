module unir(
input logic [3:0] estado, mov, 
input logic [11:0] matriz_in [0:3][0:3],
output logic [11:0] matriz [0:3][0:3]);

logic [11:0] matriz_aux [0:3][0:3] = '{default:0};
int n,m = 0;

always @(estado)
begin
	if(estado == 4'b0001)
	begin
		if(mov == 4'b0100)
		begin
			for(int i = 0; i<4; i++)
			begin
				n = 0;
				m=0;
				for(int j =0; j<4; j++)
				begin
					if(m ==3)
					begin
						matriz_aux[i][n] = matriz_in[i][m];
						break;
					end
					else if(matriz_in[i][m] == matriz_in [i][m+1])
					begin
						matriz_aux[i][n] = matriz_in[i][m] + matriz_in [i][m+1];
						m=m +2;
						n = n+1;
					end
					else if(matriz_in[i][m] != 12'b000000000000)
					begin
						matriz_aux[i][n] = matriz_in[i][m];
						n = n+1;
						m=m +1;
					end
					else
					begin
						m = m+1;
					end
				end
			end
		end
		if(mov == 4'b0011)
		begin
			for(int i = 0; i<4; i++)
			begin
				n = 3;
				m=3;
				for(int j =3; j>=0; j--)
				begin
					if(m ==0)
					begin
						matriz_aux[i][n] = matriz_in[i][m];
						break;
					end
					else if(matriz_in[i][m] == matriz_in [i][m-1])
					begin
						matriz_aux[i][n] = matriz_in[i][m] + matriz_in [i][m-1];
						m=m -2;
						n = n-1;
					end
					else if(matriz_in[i][m] != 12'b000000000000)
					begin
						matriz_aux[i][n] = matriz_in[i][m];
						n = n-1;
						m=m -1;
					end
					else
					begin
						m = m-1;
					end
				end
			end
		end
		if(mov == 4'b0101)
		begin
			for(int i = 0; i<4; i++)
			begin
				n = 0;
				m=0;
				for(int j =0; j<4; j++)
				begin
					if(m ==3)
					begin
						matriz_aux[n][i] = matriz_in[m][i];
						break;
					end
					else if(matriz_in[m][i] == matriz_in [m+1][i])
					begin
						matriz_aux[n][i] = matriz_in[m][i] + matriz_in [m+1][i];
						m=m +2;
						n = n+1;
					end
					else if(matriz_in[m][i] != 12'b000000000000)
					begin
						matriz_aux[n][i] = matriz_in[m][i];
						n = n+1;
						m=m +1;
					end
					else
					begin
						m = m+1;
					end
				end
			end
		end
		if(mov == 4'b0110)
		begin
			for(int i = 0; i<4; i++)
			begin
				n = 3;
				m=3;
				for(int j =3; j>=0; j--)
				begin
					if(m ==0)
					begin
						matriz_aux[n][i] = matriz_in[m][i];
						break;
					end
					else if(matriz_in[m][i] == matriz_in [m-1][i])
					begin
						matriz_aux[n][i] = matriz_in[m][i] + matriz_in [m-1][i];
						m=m -2;
						n = n-1;
					end
					else if(matriz_in[m][i] != 12'b000000000000)
					begin
						matriz_aux[n][i] = matriz_in[m][i];
						n = n-1;
						m=m -1;
					end
					else
					begin
						m = m-1;
					end
				end
			end
		end
	end
end

assign matriz = matriz_aux;


endmodule
