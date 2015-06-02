`timescale 1ns / 1ps

module ALU
  (
   input       reset,
   input       clk,
   input       sigALUOp,
   input [7:0] operand1,
   input [7:0] operand2,
   output [7:0] result,
   output [1:0] flags
   );

endmodule // ALU
