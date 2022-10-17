module data_mem (
  input clk,
  input [31:0] mem_address,
  input [31:0] data_in,
  input write_en,
  input read_en,
  output [31:0] data_out
);

reg [31:0] ram [1023:0];
wire [9:0] ram_addr = mem_address[11:2];

always @(posedge clk) begin
  if (write_en)
    ram[ram_addr] <= data_in;
end

assign data_out = (read_en == 1'b1) ? ram[ram_addr] : 32'd0;
endmodule
