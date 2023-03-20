module sumador_tb;
 // Inputs
 logic [5:0] input1;
 logic [5:0] input2;
 // Outputs
 logic [5:0] answer;
 logic cout;

 // Instantiate the Unit Under Test (UUT)
 sumador #(6) uut (
  .num1(input1), 
  .num2(input2), 
  .result(answer),
  .c_o(cout)
 );

 initial begin
  // Initialize Inputs
  input1 = 63;
  input2 = 2;
  #100;
  
  input1 = 63;
  input2 = 0;
  #100;
  
  input1 = 63;
  input2 = 5;
  #100;
  
  input1 = 60;
  input2 = 3;
  #100;
  // Add stimulus here
 end
      
endmodule