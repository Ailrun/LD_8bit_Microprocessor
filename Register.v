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

   reg [7:0]    registers[3:0];

   assign readData1 = registers[readReg1];
   assign readData2 = registers[readReg2];

   integer      ind0, ind1;

   initial
     begin
        for (ind0 = 0; ind0 < 4; ind0 = ind0 + 1)
          registers[ind0] <= 8'b0;
     end

   always @(posedge clk or posedge reset)
     begin
        if (reset)
          begin
             for (ind1 = 0; ind1 < 4; ind1 = ind1 + 1)
               registers[ind1] <= 8'b0;
          end
        else
          begin
             registers[writeReg] <= (sigRegWrite?writeData:registers[writeReg]);
          end
     end

endmodule // Register
