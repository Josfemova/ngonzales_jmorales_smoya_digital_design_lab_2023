module mux_param #(parameter largo_bit = 6, largo_control = 3)
(input logic [largo_bit-1:0] a,b,c,d,e,f,g,h,
input logic[largo_control-1:0] control,
output logic [largo_bit -1:0] out);

always@ (control,a,b,c,d)

begin 
	case(control)
	
	0:
		out= a;
	1:
		out= b;
	2:
		out= c;
	3:
		out= d;
	4:
		out =e;
	5:
		out = f;
	6:
		out = g;
	7:
		out = h;
	endcase


end 
endmodule
