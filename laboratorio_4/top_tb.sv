module top_tb();
logic [3:0] estado =0;
logic rst, btn_izq,btn_der,btn_up,btn_down, start, fin;
logic clk =0;
logic [11:0] matriz [0:3][0:3];
logic[27:0] catodo;

//top top_(estado,mov,matriz_in,matriz);

juego_2048 #(16)juego_2048_(rst,clk, btn_izq,btn_der,btn_up,btn_down, start, fin,estado,matriz,catodo);

always #10 clk = ~clk;

initial begin
	
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
fin =0;
start =0;

#100

rst =0;
btn_izq =0;
btn_der=0;
btn_up=0;
btn_down =0;
fin =0;
start =1;

#200

rst =0;
btn_izq =1;
btn_der=0;
btn_up=0;
btn_down =0;
fin =0;
start =0;

#100

rst =0;
btn_izq =1;
btn_der=0;
btn_up=0;
btn_down =0;
fin =0;
start =0;

#100

rst =0;
btn_izq =0;
btn_der=0;
btn_up=0;
btn_down =0;
fin =0;
start =0;

#100

rst =0;
btn_izq =0;
btn_der=1;
btn_up=0;
btn_down =0;
fin =0;
start =0;
end

endmodule