module inst_mem (
  input [31:0] mem_address,
  output [31:0] data_out
);

integer i;

wire [10:0] rom_addr = mem_address[12:2];

reg [31:0] rom [2047:0];

initial  
      begin  
                rom[0] = 32'h00000000;
                rom[1] = 32'h14020001;
                rom[2] = 32'h1403000F;
                rom[3] = 32'h14040014;
                rom[4] = 32'h00A42800;
                rom[5] = 32'h00621801;
                rom[6] = 32'h0C030007;
                rom[7] = 32'h10000004;
                rom[8] = 32'h00000000;

                for (i = 9; i <= 2047; i++) begin
                  rom[i] = 32'd0;
                end
                
      end

assign data_out = rom[rom_addr];

endmodule
