module condlogic_tb();
  // Inputs
  reg clk;
  reg reset;
  reg [3:0] Cond;
  reg [3:0] ALUFlags;
  reg [1:0] FlagW;
  reg PCS;
  reg RegW;
  reg NoWrite;
  reg MemW;
  
  // Outputs
  wire PCSrc;
  wire RegWrite;
  wire MemWrite;
  
  
  condlogic dut(
    .clk(clk),
    .reset(reset),
    .Cond(Cond),
    .ALUFlags(ALUFlags),
    .FlagW(FlagW),
    .PCS(PCS),
    .RegW(RegW),
    .NoWrite(NoWrite),
    .MemW(MemW),
    .PCSrc(PCSrc),
    .RegWrite(RegWrite),
    .MemWrite(MemWrite)
  );
  
  // Clock 
  always begin
    #5 clk = ~clk;
  end
  
  
  initial begin
   
    clk = 0;
    reset = 0;
    Cond = 0;
    ALUFlags = 0;
    FlagW = 0;
    PCS = 0;
    RegW = 0;
    NoWrite = 0;
    MemW = 0;
    
    
    #10;
    
    // Caso 1
    #5 Cond = 4'b0000; // EQ
    #5 ALUFlags = 4'b0000;
    #5 FlagW = 2'b00;
    #5 PCS = 0;
    #5 RegW = 1;
    #5 NoWrite = 0;
    #5 MemW = 1;
    // outputs:
    // PCSrc = 0
    // RegWrite = 0
    // MemWrite = 0
    #5;
    
    // Caso 2
    #5 Cond = 4'b1001; // LS
    #5 ALUFlags = 4'b1010;
    #5 FlagW = 2'b10;
    #5 PCS = 1;
    #5 RegW = 0;
    #5 NoWrite = 1;
    #5 MemW = 1;
    // outputs:
    // PCSrc = 1
    // RegWrite = 0
    // MemWrite = 1
    #5;
    
    // Caso 3
    #5 Cond = 4'b1011; // LT
    #5 ALUFlags = 4'b1100;
    #5 FlagW = 2'b11;
    #5 PCS = 0;
    #5 RegW = 1;
    #5 NoWrite = 0;
    #5 MemW = 0;
    // outputs:
    // PCSrc = 0
    // RegWrite = 1
    // MemWrite = 0
    #5;
    
    // Caso 4
    #5 Cond = 4'b1110; // Always
    #5 ALUFlags = 4'b0111;
    #5 FlagW = 2'b10;
    #5 PCS = 1;
    #5 RegW = 1;
    #5 NoWrite = 1;
    #5 MemW = 1;
    // outputs:
    // PCSrc = 1
    // RegWrite = 1
    // MemWrite = 1
    #5;
    
  end
endmodule