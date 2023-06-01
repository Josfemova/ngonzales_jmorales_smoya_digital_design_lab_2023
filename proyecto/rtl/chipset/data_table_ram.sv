module data_table_ram #(parameter WIDTH=32, LENGTH=256*8)
( 
    output reg [(WIDTH-1):0] rd_a,
    input [(WIDTH-1):0] wd_a,
    input [(WIDTH-1):0] addr_a,
    input we, clk
);
    reg [(WIDTH-1):0] mem [(LENGTH-1):0];

    always @ (posedge clk) begin
        rd_a <= mem[addr_a]; 
        if (we) mem[addr_a] <= wd_a;
    end
endmodule