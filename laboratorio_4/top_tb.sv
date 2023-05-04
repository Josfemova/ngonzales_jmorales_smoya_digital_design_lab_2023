module top_tb();
logic [3:0] estado =0;
logic [2:0]mov=0;
logic rst, btn_izq,btn_der,btn_up,btn_down,win,lose, start, fin;
logic clk =0;
logic [11:0] matriz [0:3][0:3];
logic [11:0] matriz_in [0:3][0:3];

//top top_(estado,mov,matriz_in,matriz);

top top_(rst,clk, btn_izq,btn_der,btn_up,btn_down,win,lose, start, fin,matriz_in,estado, mov,matriz);

always #10 clk = ~clk;

initial begin

for(int i = 0; i < 4; i++) begin
		for(int j = 0; j < 4; j++) begin
      matriz_in[i][j] <= 12'b0;
		end
	end
	matriz_in [0][0] <= 12'b00000000000;
	matriz_in [0][1] <= 12'b00000000000;
	matriz_in [0][2] <= 12'b00000000000;
	matriz_in [0][3] <= 12'b00000001000;
	matriz_in [1][0] <= 12'b00000000000;
	matriz_in [1][1] <= 12'b00000000000;
	matriz_in [1][2] <= 12'b00000001000;
	matriz_in [1][3] <= 12'b00000000010;
	matriz_in [2][0] <= 12'b00000000000;
	matriz_in [2][1] <= 12'b00000000000;
	matriz_in [2][2] <= 12'b00000000010;
	matriz_in [2][3] <= 12'b00000000010;
	matriz_in [3][0] <= 12'b00000000000;
	matriz_in [3][1] <= 12'b00000000000;
	matriz_in [3][2] <= 12'b00000000100;
	matriz_in [3][3] <= 12'b00000000010;
	
for(int i = 0; i < 4; i++) begin
		for(int j = 0; j < 4; j++) begin
      matriz[i][j] <= 12'b0;
		end
	end

rst =0;
btn_izq =0;
btn_der=0;
btn_up=0;
btn_down =0;
win =0;
lose =0;
fin =0;
start =0;

#100

rst =0;
btn_izq =0;
btn_der=0;
btn_up=0;
btn_down =0;
win =0;
lose =0;
fin =0;
start =1;

#200

rst =0;
btn_izq =1;
btn_der=0;
btn_up=0;
btn_down =0;
win =0;
lose =0;
fin =0;
start =0;

#100

rst =0;
btn_izq =1;
btn_der=0;
btn_up=0;
btn_down =0;
win =0;
lose =0;
fin =0;
start =0;

#100

rst =0;
btn_izq =0;
btn_der=0;
btn_up=0;
btn_down =0;
win =0;
lose =0;
fin =1;
start =0;
end

endmodule