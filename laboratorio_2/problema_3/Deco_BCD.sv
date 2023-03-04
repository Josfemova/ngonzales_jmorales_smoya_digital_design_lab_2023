module top(
input logic [5:0] bin,
output logic [13:0] catodo
);
logic [7:0] bcd;

logic [13:0] catodo_aux;

assign catodo = ~ catodo_aux;


Bin2Bcd deco(bin,bcd);

catodo_control control(bcd[3:0],bcd[7:4],catodo_aux);


endmodule
