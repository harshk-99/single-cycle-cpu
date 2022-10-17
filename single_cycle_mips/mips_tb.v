`timescale 1ns/1ns
`include "mips_32.v"

module mips_tb;

reg clk;
reg reset;

integer i;

mips_dpu uut (clk, reset);

initial begin
  $dumpfile("mips_tb.vcd");
  $dumpvars(0, mips_tb);
  clk = 0;
  forever #10 clk = ~clk;
end

initial begin
  $monitor("PC: 0x%0h\n reg2 = 0x%0d\n reg3 = 0x%0h\n reg4 = 0x%0h\n reg5 = 0x%0h\n", 
    uut.pc_current, 
    uut.register_file.reg_file[2],
    uut.register_file.reg_file[3],
    uut.register_file.reg_file[4],
    uut.register_file.reg_file[5]
  );
  reset = 1;
  #10;
  reset = 0;
  #1300;
  $monitor("Took 62 clocks to complete. Execution time: 1.24us");
  $display("Contents of Register file:");
  for(i = 0; i <= 7; i++) begin
    $write("reg%0d = 0x%0h\t", i, uut.register_file.reg_file[i]);
    $write("reg%0d = 0x%0h\t", i+8, uut.register_file.reg_file[i+8]);
    $write("reg%0d = 0x%0h\t", i+16, uut.register_file.reg_file[i+16]);
    $write("reg%0d = 0x%0h\n", i+24, uut.register_file.reg_file[i+24]);
  end
  $finish;
end

endmodule
