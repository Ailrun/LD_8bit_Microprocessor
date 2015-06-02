`timescale 1ns / 1ps

module PCCounter
  (
   input        reset,
   input        clk,
   input        sigBranch,
   input [7:0]  adding,
   output [7:0] nextPC,
   output [1:0] flags
   );

   reg          pc = 0;

   assign nextPC = pc;

   //Yet incompleted

   always @(posedge clk or posedge reset)
     begin
        if (reset)
          begin
             pc = 0;
          end
        else
          begin
             pc <= nextPC;
          end
     end

endmodule
