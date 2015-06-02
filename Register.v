`timescale 1ns / 1ps

module Register
  (
   input       reset,
   input       clk,
   input       sigRegWrite,
   input [1:0] readReg1,
   input [1:0] readReg2,
   input [1:0] writeReg,
   input [7:0] writeData,
   output [7:0] readData1,
   output [7:0] readData2
   );

endmodule // Register
