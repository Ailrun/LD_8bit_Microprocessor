`timescale 1ns / 1ps

module Data_Memory
  (
   input        reset,
   input        clk,
   input        sigMemRead,
   input        sigMemWrite,
   input [7:0]  dataAddress,
   input [7:0]  writeData,
   output [7:0] readData
   );

endmodule // Data_Memory
