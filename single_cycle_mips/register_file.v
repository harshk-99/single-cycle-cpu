module register_file (
  input clk,
  input rst,
  input reg_write_en,
  input [4:0] reg_write_addr,
  input [31:0] reg_write_data,
  input [4:0] reg_read_addr_1,
  input [4:0] reg_read_addr_2,
  output [31:0] reg_read_data_1,
  output [31:0] reg_read_data_2
);

reg [31:0] reg_file [31:0];

integer i;

always @(posedge clk or posedge rst) begin
  if (rst) begin
    for(i = 0; i <= 31; i++) begin
      reg_file[i] <= 32'b0;
    end
  end else begin
    if (reg_write_en & (reg_write_addr != 0 | reg_write_addr != 31)) begin
      reg_file[reg_write_addr] <= reg_write_data;
    end
  end
end

assign reg_read_data_1 = (reg_read_addr_1 == 0) ? 32'b0 : reg_file[reg_read_addr_1];
assign reg_read_data_2 = (reg_read_addr_2 == 0) ? 32'b0 : reg_file[reg_read_addr_2];

endmodule
