module BCD_DECO_TB;

logic[7:0] bcd;
logic [3:0] bin;

top UUT(bin,bcd);


initial
begin
bin = 15;

#40

bin = 9;

#40;

end
	
endmodule
