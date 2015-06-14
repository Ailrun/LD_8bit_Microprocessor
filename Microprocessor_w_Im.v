`timescale 1ns / 1ps

module Microprocessor_w_Im#(parameter OUTER_CLK_FRQ = 1000000,
                            INTER_CLK_FRQ = 10,
                            LOWER_DMEM_LIMIT = 0, HIGHER_DMEM_LIMIT = 255,
                            LOWER_IMEM_LIMIT = 0, HIGHER_IMEM_LIMIT = 255)
   (
    input reset,
    input clk,
    output [6:0] lowerHex,
    output [6:0] higherHex,
    output [1:0] flags
    );

   wire [7:0]    instruction, pc;

   Microprocessor#(OUTER_CLK_FRQ, INTER_CLK_FRQ,
                   LOWER_DMEM_LIMIT, HIGHER_DMEM_LIMIT)
   micro (.reset(reset), .outerClk(clk), .instruction(instruction), .pc(pc),
          .lowerHex(lowerHex), .higherHex(higherHex), .flags(flags));

   Instruction_Memory#(LOWER_IMEM_LIMIT, HIGHER_IMEM_LIMIT)
   imem (.readAddress(pc), .instruction(instruction));

endmodule
