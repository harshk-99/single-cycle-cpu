`include "data_mem.v"
`include "alu_cu.v"
`include "inst_mem.v"
`include "register_file.v"
`include "alu.v"
`include "cu.v"

module mips_dpu (
  input clk, reset
);

reg [31:0] pc_current;
wire signed [31:0] pc_next, pc4;
wire [31:0] instr;
wire reg_dest, jump, branch, mem_read, mem_to_reg, mem_write, ALUsrc, reg_write, jal;
wire [1:0] ALUOp;
wire [4:0] reg_write_addr, reg_write_addr_intm;
wire [31:0] reg_write_data;
wire [4:0] reg_read_addr_1;
wire [4:0] reg_read_addr_2;
wire [31:0] reg_read_data_1;
wire [31:0] reg_read_data_2;
wire [31:0] sign_ext, data2;
wire [2:0] ALU_ctrl;
wire [31:0] ALU_out;
wire zero;
wire [31:0] mem_read_data, mem_read_data_intm;
wire [31:0] jump_addr_intm;

always @(posedge clk or posedge reset) begin
  if (reset)
    pc_current <= 32'd0;
  else
    pc_current <= pc_next;
end

assign pc4 = pc_current + 32'd4;

inst_mem instruction_memory (pc_current, instr);
control_unit cu (instr[31:26], reset, reg_dest, jump, branch, mem_read, mem_to_reg, mem_write, ALUsrc, reg_write, jal, ALUOp);


assign reg_read_addr_1 = instr[25:21];
assign reg_read_addr_2 = instr[20:16];
assign reg_write_addr_intm = (reg_dest == 1'b1) ? instr[15:11] : instr[20:16];
assign reg_write_addr = (jal == 1'b1) ?  5'b11111 : reg_write_addr_intm;

register_file register_file (clk, reset, reg_write, reg_write_addr, reg_write_data, reg_read_addr_1, reg_read_addr_2, reg_read_data_1, reg_read_data_2);

assign sign_ext = {{16{instr[15]}}, instr[15:0]};

assign data2 = (ALUsrc == 1'b1) ? sign_ext : reg_read_data_2;

alu_cu alu_control (ALUOp, instr[5:0], ALU_ctrl);
alu alu (reg_read_data_1, data2, ALU_ctrl, ALU_out, zero);
data_mem data_memory (clk, ALU_out, reg_read_data_2, mem_write, mem_read, mem_read_data);

assign mem_read_data_intm = (mem_to_reg == 1'b1) ? mem_read_data : ALU_out;
assign reg_write_data = (jal == 1'b1) ? pc4 : mem_read_data_intm;

assign jump_addr_intm = (branch == 1'b1 && zero == 1'b1) ? ({sign_ext[29:2], 2'b00} + pc4) : pc4;
assign pc_next = (jump == 1'b1) ? {pc4[31:28], instr[25:0], 2'b00} : jump_addr_intm;

endmodule
