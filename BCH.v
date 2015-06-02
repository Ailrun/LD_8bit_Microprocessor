`timescale 1ns / 1ps

module BCH
  (
   input [3:0]  binary,
   output [6:0] hex
   );

   assign hex = (binary == 4'b0000)? 7'h3F:
                (binary == 4'b0001)? 7'h06:
                (binary == 4'b0010)? 7'h5B:
                (binary == 4'b0011)? 7'h4F:
                (binary == 4'b0100)? 7'h66:
                (binary == 4'b0101)? 7'h6D:
                (binary == 4'b0110)? 7'h7D:
                (binary == 4'b0111)? 7'h07:
                (binary == 4'b1000)? 7'h7F:
                (binary == 4'b1001)? 7'h6F:
                (binary == 4'b1010)? 7'h77:
                (binary == 4'b1011)? 7'h7C:
                (binary == 4'b1100)? 7'h39:
                (binary == 4'b1101)? 7'h5E:
                (binary == 4'b1110)? 7'h79:
                7'h71;
endmodule
