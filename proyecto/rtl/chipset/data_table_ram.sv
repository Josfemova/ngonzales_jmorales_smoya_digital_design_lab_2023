module data_table_ram( 
    output reg [7:0] rdata,
    input [7:0] wdata,
    input [4:0] write_address, read_address,
    input we, clk
);
    reg [7:0] mem [31:0];

    always @ (posedge clk) begin
        if (we)
            mem[write_address] <= wdata;
				rdata <= mem[read_address]; 
    end
endmodule