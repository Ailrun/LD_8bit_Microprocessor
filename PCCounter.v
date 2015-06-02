`timescale 1ns / 1ps

module PCCounter
  (
   input        reset,
   input        clk,
   input        sigBranch,
   input [7:0]  adding,
   output [7:0] pcAddress,
   output [1:0] flags
   );

   reg [7:0]    pc = 8'b0;

   wire         OF1,OF2;
   wire [7:0]   W1, W2;

   assign pcAddress = pc;
   assign flags[1] = OF1 | OF2;
   assign flags[0] = (sigBranch && adding[1] == 1'b1)?1'b1:1'b0;

   CLA_8bit cla8_0(.A(pc), .B(8'b0000_0001), .Ci(1'b0), .S(W1), .OF(OF1));
   CLA_8bit cla8_1(.A(W1), .B(adding), .Ci(1'b0), .S(W2), .OF(OF2));

   always @(posedge clk or posedge reset)
     begin
        if (reset)
          begin
             pc <= 8'b0;
          end
        else
          begin
             pc <= sigBranch?W2:W1;
          end
     end

endmodule
