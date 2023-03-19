module mux_tb;

localparam largo_bit = 4;
localparam largo_control= 3;

logic [3:0] a,b,c,d,e,f,g,h;
logic [2:0] sel;
logic [3:0] out;

mux_param #(largo_bit, largo_control) mux_param(a,b,c,d,e,f,g,h,sel,out);

initial begin
  a = 4'b0001;
  b = 4'b0000;
  c = 4'b0010;
  d = 4'b0011;
  e = 4'b0100;
  f = 4'b0101;
  g = 4'b0110;
  h = 4'b0111;
  sel = 3'b001;
  #5;
  sel = 3'b010;
  #5;
  sel = 3'b111;
  #5;
end

endmodule