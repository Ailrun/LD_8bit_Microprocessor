`timescale 1ns / 1ps

module Microprocessor
  ( // Yet there is some question. For ex/ is clk input? when we can get inst?
   input        reset,
   input        clk,
   input [7:0]  instruction,
   output [7:0] pc,
   output [6:0] lowerHex,
   output [6:0] higherHex,
   output [1:0] flags //flags[0] : inf loop, flags[1] : OF
   );


   wire         sigBranch, sigMemtoReg, sigMemRead, sigMemWrite,
                sigALUOp, sigALUSrc, sigRegWrite, sigRegDst;

   wire [7:0]   memToReg, aluToReg;

   Control ctrl(.reset(reset), .clk(clk), .op(instruction[7:6]),
                .sigBranch(sigBranch), .sigMemtoReg(sigMemtoReg),
                .sigMemRead(sigMemRead), .sigMemWrite(sigMemWrite),
                .sigALUOp(sigALUOp), .sigALUSrc(sigALUSrc),
                .sigRegWrite(sigRegWrite), .sigRegDst(sigRegDst));



   wire [1:0]   writeReg = (sigRegDst?
                            instruction[1:0]:
                            instruction[3:2]);
   wire [7:0]   regWriteData = (sigMemtoReg?
                                memToReg:
                                aluToReg);
   wire [7:0]   regReadData1, regReadData2;

   Register rgst(.reset(reset), .clk(clk),
                 .sigRegWrite(sigRegWrite),
                 .readReg1(instruction[5:4]), .readReg2(instruction[3:2]),
                 .writeReg(writeReg),
                 .writeData(regWriteData),
                 .readData1(regReadData1), .readData2(regReadData2));



   wire [7:0]   signExtend = { {7{instruction[1]}}, instruction[0] };
   wire [7:0]   operand2 = (sigALUSrc?
                            signExtend:
                            regReadData2);
   wire [7:0]   aluResult;
   assign aluToReg = aluResult;

   ALU alu(.reset(reset), .clk(clk),
           .sigALUOp(sigALUOp),
           .operand1(regReadData1), .operand2(operand2),
           .result(aluResult),
           .flags(aluFlags));



   wire [7:0]   memReadData;
   assign memToReg = memReadData;

   Data_Memory dmem(.reset(reset), .clk(clk),
                    .sigMemRead(sigMemRead), .sigMemWrite(sigMemWrite),
                    .dataAddress(aluResult), .writeData(regReadData2),
                    .readData(memReadData));



   PCCounter pcC(.reset(reset), .clk(clk),
                .sigBranch(sigBranch),
                .adding(signExtend), .pcAddress(pc),
                .flags(pcFlags));

   assign flags = aluFlags | pcFlags;

   BCH bch_low(.binary(regWriteData[3:0]), .hex(lowerHex));
   BCH bch_high(.binary(regWriteData[7:4]), .hex(higherHex));

endmodule
