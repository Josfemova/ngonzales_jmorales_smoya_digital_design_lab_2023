module arm_tb();
  // Inputs
  reg clk;
  reg reset;
  reg [31:0] Instr;
  reg [31:0] ReadData;
  
  // Outputs
  wire [31:0] PC;
  wire MemWrite;
  wire [31:0] ALUResult;
  wire [31:0] WriteData;

  arm dut (
    .clk(clk),
    .reset(reset),
    .PC(PC),
    .Instr(Instr),
    .MemWrite(MemWrite),
    .ALUResult(ALUResult),
    .WriteData(WriteData),
    .ReadData(ReadData)
  );


  always #5 clk = ~clk;


  initial begin
    clk = 0;
    #10 reset = 0;

  
    #20;

    Instr = 32'b00011000000100010000000000000;
    ReadData = 32'hFEDCBA98;
    #100;
   
    
    
  end
endmodule