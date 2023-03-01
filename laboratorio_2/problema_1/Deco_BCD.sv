module top(
input logic [3:0] bin,
output logic [13:0] catodo
);
logic [7:0] bcd;


Bin2Bcd deco(bin,bcd);

catodo_control control(bcd[3:0],bcd[7:4],catodo);


endmodule
