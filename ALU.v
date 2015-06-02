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

   wire         OF;
   wire [7:0]   addResult;

   CLA_8bit cla8_0(.A(operand1), .B(operand2), .Ci(1'b0), .S(addResult), .OF(OF));

   assign result = reset?0:(sigALUOp?addResult:addResult); // for extension
   assign flags = {OF, 0};

endmodule // ALU
