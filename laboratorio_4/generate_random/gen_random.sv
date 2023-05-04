

module gen_random(
input logic [3:0] estado,
input logic [11:0] matriz_in [0:3][0:3],
output logic [11:0] matriz [0:3][0:3]
);

logic [11:0] matriz_aux [0:3][0:3] = '{default:0};
logic added = 0;
always@(estado)
begin
	added = 0;
	if(estado == 4'b0100)
	begin
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

end

assign matriz = matriz_aux;


endmodule


