`timescale 1ns / 1ps

module Data_Memory#(parameter LOWER_DMEM_LIMIT = 0, HIGHER_DMEM_LIMIT = 255)
  (
   input        reset,
   input        clk,
   input        sigMemRead,
   input        sigMemWrite,
   input [7:0]  dataAddress,
   input [7:0]  writeData,
   output [7:0] readData
   );

   reg [7:0]    dataRegisters[LOWER_DMEM_LIMIT:HIGHER_DMEM_LIMIT];

   assign readData = dataRegisters[dataAddress];

// integer      ind0;
   integer      ind1;

/* Maybe Make Error
   initial
     begin
        for (ind0 = LOWER_DMEM_LIMIT; ind0 < HIGHER_DMEM_LIMIT+1; ind0 = ind0 + 1)
          dataRegisters[ind0] <= ind0;
     end
*/

   always @(posedge clk or posedge reset)
     begin
        if (reset)
          begin
             for (ind1 = LOWER_DMEM_LIMIT; ind1 < HIGHER_DMEM_LIMIT+1; ind1 = ind1 + 1)
               dataRegisters[ind1] <= ind1;
          end
        else if (sigMemWrite)
          begin
             dataRegisters[dataAddress] <= writeData;
          end
     end

endmodule // Data_Memory
