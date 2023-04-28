module PLL
  #(
    parameter DIV_FACTOR = 2 // Divide factor of the clock divider
  )
  (
    input logic clk_in, // Input clock signal
    output logic clk_out // Output clock signal
  );

  logic [DIV_FACTOR-1:0] cnt;

  always_ff @(posedge clk_in) begin
    if (cnt == (DIV_FACTOR-1))
      cnt <= 0;
    else
      cnt <= cnt + 1;
  end

  assign clk_out = (cnt == (DIV_FACTOR-1)) ? 1'b1 : 1'b0;

endmodule
