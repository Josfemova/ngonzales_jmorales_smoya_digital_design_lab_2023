module mover_abajo(
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
	

end

assign matriz = matriz_aux;


endmodule 