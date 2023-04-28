module PLL_tb;

  logic clk_in;  // Input clock signal
  logic clk_out; // Output clock signal

  PLL #(.DIV_FACTOR(2)) dut (
    .clk_in(clk_in),
    .clk_out(clk_out)
  );

  initial begin
    clk_in = 0;
    forever #5 clk_in = ~clk_in; // Input clock period is 10 time units
  end

  always @(posedge clk_out) begin
    $display("Output clock signal toggled at time %0t", $time);
  end

endmodule