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

endmodule // Control
