`timescale 1ns / 1ps

module Control
  (
   input       reset,
   input       clk,
   input [1:0] op,
   output      sigBranch,
   output      sigMemtoReg,
   output      sigMemRead,
   output      sigMemWrite,
   output      sigALUOp,
   output      sigALUSrc,
   output      sigRegWrite,
   output      sigRegDst
   );

   assign sigBranch = reset?1'b0:((op == 2'b11)?1'b1:1'b0);
   assign sigMemtoReg = reset?1'b0:((op == 2'b01)?1'b1:1'b0);
   assign sigMemRead = reset?1'b0:((op == 2'b01)?1'b1:1'b0);
   assign sigMemWrite = reset?1'b0:((op == 2'b10)?1'b1:1'b0);
   assign sigALUOp = reset?1'b0:((op == 2'b00)?1'b1:1'b0);
   assign sigALUSrc = reset?1'b0:((op[1] != op[0])?1'b1:1'b0);
   assign sigRegWrite = reset?1'b0:((op[1] == 1'b0)?1'b1:1'b0);
   assign sigRegDst = reset?1'b0:((op == 2'b00)?1'b1:1'b0);

endmodule // Control
