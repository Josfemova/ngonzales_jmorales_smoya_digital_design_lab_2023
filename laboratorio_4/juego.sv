module juego(
input logic [3:0] estado,
input logic [2:0] mov, 
input logic [11:0] matriz_in [0:3][0:3],
output logic [11:0] matriz [0:3][0:3]
);

int n,m = 0;

logic [11:0] matriz_aux [0:3][0:3] = '{default:0};
logic added = 0;
always @(estado)
begin
	if(mov == 3'b011 && estado == 4'b0100)
	begin
		for (int i=0; i<4; i++)begin
		n =0;
			for(int j=0; j<4; j++)begin
				if(matriz_in[j][i] != 12'b000000000000)
				begin
					matriz_aux[n][i] = matriz_in[j][i];
					n=n+1;
				end
			end
		end
	end
	if(mov == 3'b100 && estado == 4'b0100)
	begin
		for (int i=0; i<4; i++)begin
		n =3;
			for(int j=3; j>=0; j--)begin
				if(matriz_in[j][i] != 12'b000000000000)
				begin
					matriz_aux[n][i] = matriz_in[j][i];
					n=n-1;
				end
			end
		end
	end
	if(mov == 3'b010 && estado == 4'b0100)
	begin
		for (int i=0; i<4; i++)begin
		n =3;
			for(int j=3; j>=0; j--)begin
				if(matriz_in[i][j] != 12'b000000000000)
				begin
					matriz_aux[i][n] = matriz_in[i][j];
					n=n-1;
				end
			end
		end
	end
	if(mov == 3'b001 && estado == 4'b0100)
	begin
		for (int i=0; i<4; i++)begin
		n =0;
			for(int j=0; j<4; j++)begin
				if(matriz_in[i][j] != 12'b000000000000)
				begin
					matriz_aux[i][n] = matriz_in[i][j];
					n=n+1;
				end
			end
		end
	end
	if(estado == 4'b0110)
	begin
		if(mov == 3'b001)
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
		if(mov == 3'b010)
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
		if(mov == 3'b011)
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
		if(mov == 3'b100)
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
	if(estado == 4'b0001)
	begin
		added = 0;
		for (int i=0; i<4; i++)
		begin
			for(int j=0; j<4; j++)
			begin
				if((matriz_in[i][j] == 12'b000000000000) && !added)
				begin
					matriz_aux[i][j] = 12'b000000000010;
					added = 1;
				end
				else
				begin
					matriz_aux[i][j] = matriz_in[i][j];
				end
			end
		end
	end
	if(estado == 4'b0010 || estado == 4'b0101 || estado == 4'b0111)
	begin
		matriz <= matriz_aux;
	end
	if(estado == 4'b1001 || estado == 4'b1010 || estado == 1011)
	begin
		matriz_aux = '{default:0};
	end

end

//assign matriz = matriz_aux;
endmodule