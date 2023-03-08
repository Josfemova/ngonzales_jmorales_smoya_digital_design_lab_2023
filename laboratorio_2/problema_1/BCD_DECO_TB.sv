module BCD_DECO_TB;

logic[13:0] catodo;
logic [3:0] bin;

top UUT(bin,catodo);


initial
begin
bin = 15;

#40

bin = 9;

#40;

end
	
endmodule
