module top_tb();
logic [3:0] estado;
logic clk =0;
logic [11:0] matriz [0:3][0:3];
logic [11:0] matriz_in [0:3][0:3];

top top_(estado,matriz_in,matriz);


always #50 clk = ~clk;

initial begin
	for(int i = 0; i < 4; i++) begin
		for(int j = 0; j < 4; j++) begin
      matriz_in[i][j] <= 12'b0;
		end
	end
	matriz_in [0][0] <= 12'b00000000010;
	matriz_in [0][1] <= 12'b00000000011;
	matriz_in [1][0] <= 12'b00000000100;
	matriz_in [1][2] <= 12'b00000001000;
	estado = 4'b0000;
	for(int i = 0; i < 4; i++) begin
		for(int j = 0; j < 4; j++) begin
      matriz[i][j] <= 12'b0;
		end
	end
	#100
	
	estado = 4'b0001;
	
	#100;









end

endmodule