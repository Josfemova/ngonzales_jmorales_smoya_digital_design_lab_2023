module mover_izquierda(
input logic [3:0] estado,
input logic [11:0] matriz_in [0:3][0:3],
output logic [11:0] matriz [0:3][0:3]
);

int n =0;

logic [11:0] matriz_aux [0:3][0:3] = '{default:0};

always @(estado)
begin
	if(estado == 4'b0001)
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
	

end

assign matriz = matriz_aux;


endmodule 