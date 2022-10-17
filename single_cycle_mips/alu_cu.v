module alu_cu (
  input [1:0] ALUOp,
  input [5:0] func,
  output reg [2:0] ALU_ctrl
);

wire [7:0] ALUCtrlin;

assign ALUCtrlin = {ALUOp, func};

always @(ALUCtrlin) begin
  casex (ALUCtrlin)
    8'b00xxxxxx: ALU_ctrl = 3'b000;
    8'b01xxxxxx: ALU_ctrl = 3'b001;
    8'b10000000: ALU_ctrl = 3'b000;
    8'b10000001: ALU_ctrl = 3'b001;
    8'b10000010: ALU_ctrl = 3'b010;
    8'b10000011: ALU_ctrl = 3'b011;
    8'b10000100: ALU_ctrl = 3'b100;
    8'b10000101: ALU_ctrl = 3'b101;
    8'b10000110: ALU_ctrl = 3'b110;
    default: ALU_ctrl = 3'b000;  
  endcase
end
endmodule
