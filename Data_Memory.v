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

   reg [7:0]    dataRegisters[255:0];

   assign readData = (sigMemRead?dataRegisters[dataAddress]:0);

   integer      ind0, ind1;

   initial
     begin
        for (ind0 = 0; ind0 < 256; ind0 = ind0 + 1)
          dataRegisters[ind0] <= 8'b0;
     end

   always @(posedge clk or posedge reset)
     begin
        if (reset)
          begin
             for (ind1 = 0; ind1 < 256; ind1 = ind1 + 1)
               dataRegisters[ind1] <= 8'b0;
          end
        else
          begin
             dataRegisters[dataAddress] <= (sigMemWrite?writeData:dataRegisters[dataAddress]);
          end
     end

endmodule // Data_Memory
