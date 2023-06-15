module controller_tb;
  // Inputs
  reg clk;
  reg reset;
  reg [31:12] Instr;
  reg [3:0] ALUFlags;
  
  // Outputs
  wire [1:0] RegSrc;
  wire RegWrite;
  wire [1:0] ImmSrc;
  wire ALUSrc;
  wire [2:0] ALUControl;
  wire MemWrite;
  wire MemtoReg;
  wire PCSrc;
  
  // Instantiate the module under test
  controller dut(
    .clk(clk),
    .reset(reset),
    .Instr(Instr),
    .ALUFlags(ALUFlags),
    .RegSrc(RegSrc),
    .RegWrite(RegWrite),
    .ImmSrc(ImmSrc),
    .ALUSrc(ALUSrc),
    .ALUControl(ALUControl),
    .MemWrite(MemWrite),
    .MemtoReg(MemtoReg),
    .PCSrc(PCSrc)
  );
  
  // Clock 
  always begin
    #5 clk = ~clk;
  end
  
  // Testbench logic
  initial begin
    
    clk = 0;
    reset = 0;
    Instr = 0;
    ALUFlags = 0;
    
    
    #10;
    
    // Caso1
    #5 Instr = 32'h12345678;
    #5 ALUFlags = 4'b1010;
    // outputs:
    // RegSrc = 2'b00
    // RegWrite = 0
    // ImmSrc = 2'b00
    // ALUSrc = 0
    // ALUControl = 3'b000
    // MemWrite = 0
    // MemtoReg = 0
    // PCSrc = 0
    #5;
    
    // Caso2
    #5 Instr = 32'h87654321;
    #5 ALUFlags = 4'b0110;
    // outputs:
    // RegSrc = 2'b10
    // RegWrite = 1
    // ImmSrc = 2'b10
    // ALUSrc = 1
    // ALUControl = 3'b001
    // MemWrite = 1
    // MemtoReg = 1
    // PCSrc = 1
    #5;
    
    // Caso 3
    #5 Instr = 32'hABCDEF01;
    #5 ALUFlags = 4'b1100;
    // outputs:
    // RegSrc = 2'b00
    // RegWrite = 0
    // ImmSrc = 2'b11
    // ALUSrc = 0
    // ALUControl = 3'b010
    // MemWrite = 0
    // MemtoReg = 0
    // PCSrc = 1
    #5;
    
    // Caso 4
    #5 Instr = 32'h01234567;
    #5 ALUFlags = 4'b0011;
    // outputs:
    // RegSrc = 2'b10
    // RegWrite = 1
    // ImmSrc = 2'b01
    // ALUSrc = 1
    // ALUControl = 3'b011
    // MemWrite = 0
    // MemtoReg = 0
    // PCSrc = 0
    #5;
    
    
  end
endmodule