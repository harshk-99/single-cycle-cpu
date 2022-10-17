module alu (
  input [31:0] A,
  input [31:0] B,
  input [2:0] ALU_ctrl,
  output reg [31:0] result,
  output zero
);

always @(*) begin
  case(ALU_ctrl)
    3'b000: result = A + B;
    3'b001: result = A - B;
    3'b010: result = A && B;
    3'b011: result = A || B;
    3'b100: result = ~(A || B);
    3'b101: result = (A ^ B);
    3'b110: result = (A < B) ? 32'd1 : 32'd0;
    default:result = A + B;
    endcase
  end

assign zero = (result == 32'd0) ? 1'b1 : 1'b0;

endmodule
