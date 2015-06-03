`timescale 1ns / 1ps

module Instruction_Memory#(parameter LOWER_IMEM_LIMIT = 0, HIGHER_IMEM_LIMIT = 255)
   (
    input [7:0]  readAddress,
    output [7:0] instruction
    );

   wire [7:0]    MemByte[LOWER_IMEM_LIMIT:HIGHER_IMEM_LIMIT];

   assign MemByte[0] = 8'b01_00_01_00;
   assign MemByte[1] = 8'b01_00_10_01;
   assign MemByte[2] = 8'b00_01_10_00;
   assign MemByte[3] = 8'b10_00_10_01;
   assign MemByte[4] = 8'b11_00_00_11;

   assign instruction = MemByte[readAddress];

endmodule // Instruction_Memory
