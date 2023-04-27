module top (
input logic [3:0] estado,
input logic [11:0] matriz_in [0:3][0:3],
output logic [11:0] matriz [0:3][0:3]
);

mover_derecha mov(estado, matriz_in,matriz);




endmodule