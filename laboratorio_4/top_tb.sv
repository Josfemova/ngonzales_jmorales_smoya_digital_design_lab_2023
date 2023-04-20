module top_tb();
logic rst, btn_izq,btn_der,btn_up,btn_down,win,loose,check, start, fin;
logic clk =0;

logic [3:0] estado_act =0;

logic [3:0] i, i_1, j,j_1 =0;

top top_(rst,clk, btn_izq,btn_der,btn_up,btn_down,win,loose,check, start, fin,estado_act,i, i_1, j,j_1);


always #1 clk = ~clk;

initial begin
rst =0;
btn_izq=0;
btn_der =0;
btn_up =0;
btn_down =0;
win =0;
loose =0;
check =0;
start =1;
fin =0;

#5

rst =0;
btn_izq=1;
btn_der =0;
btn_up =0;
btn_down =0;
win =0;
loose =0;
check =0;
start =0;
fin =0;



#20

rst =0;
btn_izq=0;
btn_der =0;
btn_up =0;
btn_down =0;
win =0;
loose =0;
check =1;
start =0;
fin =0;
/*#10
rst =0;
btn_izq=0;
btn_der =0;
btn_up =0;
btn_down =0;
win =1;
loose =0;
check =0;
start =0;
fin =0;

#5 
rst =0;
btn_izq=0;
btn_der =0;
btn_up =0;
btn_down =0;
win =1;
loose =0;
check =1;
start =0;
fin =0;

#5
rst =0;
btn_izq=0;
btn_der =0;
btn_up =0;
btn_down =0;
win =1;
loose =0;
check =0;
start =0;
fin =1;*/

#5;


end

endmodule