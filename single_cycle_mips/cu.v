module control_unit (
  input [5:0] opcode,
  input reset,
  output reg reg_dest, jump, branch, mem_read, mem_to_reg, mem_write, ALUsrc, reg_write, jal,
  output reg [1:0] ALUOp
);

always @(*) begin
  if (reset == 1'b1) begin
    reg_dest = 1'b0;
    jump = 1'b0;
    branch = 1'b0;
    mem_read = 1'b0;
    mem_to_reg = 1'b0;
    mem_write = 1'b0;
    ALUsrc = 1'b0;
    reg_write = 1'b0;
    jal = 1'b0;
    ALUOp = 2'b00;
  end else begin
    case (opcode)
      6'b000000: begin            // * R - Type
        reg_dest = 1'b1;
        jump = 1'b0;
        branch = 1'b0;
        mem_read = 1'b0;
        mem_to_reg = 1'b0;
        mem_write = 1'b0;
        ALUsrc = 1'b0;
        reg_write = 1'b1;
        jal = 1'b0;
        ALUOp = 2'b10;
        end
  6'b000001: begin                // * lw
        reg_dest = 1'b0;
        jump = 1'b0;
        branch = 1'b0;
        mem_read = 1'b1;
        mem_to_reg = 1'b1;
        mem_write = 1'b0;
        ALUsrc = 1'b1;
        reg_write = 1'b1;
        jal = 1'b0;
        ALUOp = 2'b00;
        end
  6'b000010: begin                // * sw
        reg_dest = 1'b0;
        jump = 1'b0;
        branch = 1'b0;
        mem_read = 1'b0;
        mem_to_reg = 1'b0;
        mem_write = 1'b1;
        ALUsrc = 1'b1;
        reg_write = 1'b0;
        jal = 1'b0;
        ALUOp = 2'b00;
        end
  6'b000011: begin                // * beq
        reg_dest = 1'b0;
        jump = 1'b0;
        branch = 1'b1;
        mem_read = 1'b0;
        mem_to_reg = 1'b0;
        mem_write = 1'b0;
        ALUsrc = 1'b0;
        reg_write = 1'b0;
        jal = 1'b0;
        ALUOp = 2'b01;
        end
  6'b000100: begin                // * jump
        reg_dest = 1'b0;
        jump = 1'b1;
        branch = 1'b0;
        mem_read = 1'b0;
        mem_to_reg = 1'b0;
        mem_write = 1'b0;
        ALUsrc = 1'b0;
        reg_write = 1'b0;
        jal = 1'b0;
        ALUOp = 2'b00;
        end
  6'b000101: begin                // * addi
        reg_dest = 1'b0;
        jump = 1'b0;
        branch = 1'b0;
        mem_read = 1'b0;
        mem_to_reg = 1'b0;
        mem_write = 1'b0;
        ALUsrc = 1'b1;
        reg_write = 1'b1;
        jal = 1'b0;
        ALUOp = 2'b00;
        end
  6'b000110: begin                // * jal
        reg_dest = 1'b0;
        jump = 1'b1;
        branch = 1'b0;
        mem_read = 1'b0;
        mem_to_reg = 1'b0;
        mem_write = 1'b0;
        ALUsrc = 1'b0;
        reg_write = 1'b1;
        jal = 1'b1;
        ALUOp = 2'b00;
        end
  default: begin                // * nop
        reg_dest = 1'b1;
        jump = 1'b0;
        branch = 1'b0;
        mem_read = 1'b0;
        mem_to_reg = 1'b0;
        mem_write = 1'b0;
        ALUsrc = 1'b0;
        reg_write = 1'b1;
        jal = 1'b0;
        ALUOp = 2'b10;
        end
    endcase
  end
end


endmodule
