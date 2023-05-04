module gen_random_tb();
logic [3:0] estado =0;
logic [11:0] matriz [0:3][0:3];
logic [11:0] matriz_in [0:3][0:3];

logic [1:0] random = 0;


gen_random dut(estado, matriz_in, matriz);

initial begin

	for(int i = 0; i < 4; i++) begin
			for(int j = 0; j < 4; j++) begin
			matriz_in[i][j] <= 12'b0;
			end
		end
	matriz_in[0][0] <= 12'b00000001000;
	matriz_in[0][1] <= 12'b00000001000;
	matriz_in[1][1] <= 12'b00000001000;
	matriz_in[0][2] <= 12'b00000001000;
		
	estado = 4'b0000;
	#100
	estado = 4'b0100;
	#100
	estado = 4'b0000;
	matriz_in[0][3] <= 12'b00000001000;
	#100
	
	estado = 4'b0100;
	#100
	estado = 4'b0000;
	#100
	estado = 4'b0100;
end


endmodule