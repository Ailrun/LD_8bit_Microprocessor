`timescale 1ns / 1ps

module CLK_Divider#(IN_CLK_FRQ = 1000000, OUT_CLK_FRQ = 10)
   (
    input      reset,
    input      clkin,
    output reg clkout
    );

   localparam CLK_PER_CLK = IN_CLK_FRQ / (2*OUT_CLK_FRQ);

   reg [$clog2(CLK_PER_CLK):0] counter;

   always @(posedge clkin)
     begin
        if (reset)
          begin
             clkout <= 0;
             counter <= 0;
          end
        else if (counter == CLK_PER_CLK)
          begin
             clkout <= ~clkout;
             counter <= 0;
          end
        else
          begin
             counter <= counter + 1;
          end
     end // always @ (posedge clkin)
endmodule // CLK_Divider
