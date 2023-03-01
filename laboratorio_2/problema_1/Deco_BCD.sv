module top(
input logic [3:0] bin,
output logic [7:0] bcd
);

Bin2Bcd deco(bin,bcd);


endmodule
