`timescale 1ns / 1ps

module CLA_8bit
  (
   input [7:0]  A,
   input [7:0]  B,
   input        Ci,
   output [7:0] S,
   output       Co,
   output       OF,
   output       PG,
   output       GG
   );

   /* first implementation
   wire [1:0]   P,G;
   wire         C;

   CLA_4bit cla4_0(.A(A[3:0]), .B(B[3:0]), .Ci(Ci), .S(S[3:0]),
                   .PG(P[0]), .GG(G[0]));
   CLA_4bit cla4_1(.A(A[7:4]), .B(B[7:4]), .Ci(C), .S(S[7:4]),
                   .PG(P[1]), .GG(G[1]) .OF(OF));
   CLU_2bit clu2_0(.P(P), .G(G), .Ci(Ci), .Co({Co, C}));
    */

   wire [3:0]   P,G;
   wire [3:1]   C;

   CLA_2bit cla2_0(.A(A[1:0]), .B(B[1:0]), .Ci(Ci), .S(S[1:0]),
                   .PG(P[0]), .GG(G[0]));
   CLA_2bit cla2_1(.A(A[3:2]), .B(B[3:2]), .Ci(C[1]), .S(S[3:2]),
                   .PG(P[1]), .GG(G[1]));
   CLA_2bit cla2_2(.A(A[5:4]), .B(B[5:4]), .Ci(C[2]), .S(S[5:4]),
                   .PG(P[2]), .GG(G[2]));
   CLA_2bit cla2_3(.A(A[7:6]), .B(B[7:6]), .Ci(C[3]), .S(S[7:6]),
                   .PG(P[3]), .GG(G[3]), .OF(OF));

   CLU_4bit clu4_0(.P(P), .G(G), .Ci(Ci), .Co({Co, C}), .PG(PG), .GG(GG));

endmodule // CLA_8bit

module CLA_4bit
  (
   input [3:0]  A,
   input [3:0]  B,
   input        Ci,
   output [3:0] S,
   output       Co,
   output       OF,
   output       PG,
   output       GG
   );

   wire [3:0]   P,G;
   wire [3:1]   C;

   FAdd fa0(.A(A[0]), .B(B[0]), .Ci(Ci), .P(P[0]), .G(G[0]), .S(S[0]));
   FAdd fa1(.A(A[1]), .B(B[1]), .Ci(C[1]), .P(P[1]), .G(G[1]), .S(S[1]));
   FAdd fa2(.A(A[2]), .B(B[2]), .Ci(C[2]), .P(P[2]), .G(G[2]), .S(S[2]));
   FAdd fa3(.A(A[3]), .B(B[3]), .Ci(C[3]), .P(P[3]), .G(G[3]), .S(S[3]));

   CLU_4bit clu4(.P(P), .G(G), .Ci(Ci), .Co({Co,C}));

   xnor xnOF(OF, Co, C[3]);

endmodule // CLA_4bit

module CLA_2bit
  (
   input [1:0]  A,
   input [1:0]  B,
   input        Ci,
   output [1:0] S,
   output       Co,
   output       OF,
   output       PG,
   output       GG
   );

   wire [1:0]   P, G;
   wire         C;

   FAdd fa0(.A(A[0]), .B(B[0]), .Ci(Ci), .P(P[0]), .G(G[0]), .S(S[0]));
   FAdd fa1(.A(A[1]), .B(B[1]), .Ci(C), .P(P[1]), .G(G[1]), .S(S[1]));

   CLU_2bit clu2(.P(P), .G(G), .Ci(Ci), .Co({Co, C}), .PG(PG), .GG(GG));

   xnor xnOF(OF, Co, C);

endmodule

module FAdd
  (
   input  A,
   input  B,
   input  Ci,
   output P,
   output G,
   output S,
   output Co
   );

   or oP0(P, A, B);
   and aG0(G, A, B);

   xor xS0(WS0, A, B);
   xor xS1(S, WS0, Ci);

   and aC0(WC0, A, B);
   and aC1(WC1, WS0, Ci);
   or oC0(Co, WC1, WC0);

endmodule










module CLU_4bit
  (
   input [3:0]  P,
   input [3:0]  G,
   input        Ci,
   output [4:1] Co,
   output       PG,
   output       GG
   );

   and a00(W00, P[0], Ci);
   or o00(Co[1], W00, G[0]);

   and a10(W10, P[1], P[0], Ci);
   and a11(W11, P[1], G[0]);
   or o10(Co[2], W11, W10, G[1]);

   and a20(W20, P[2], P[1], P[0], Ci);
   and a21(W21, P[2], P[1], G[0]);
   and a22(W22, P[2], G[1]);
   or o20(Co[3], W22, W21, W20, G[2]);

   and a30(W30, P[3], P[2], P[1], P[0], Ci);
   and a31(W31, P[3], P[2], P[1], G[0]);
   and a32(W32, P[3], P[2], P[1]);
   and a33(W33, P[3], G[2]);
   or o30(Co[4], W33, W32, W31, W30, G[3]);

   and aPG0(PG, P[3], P[2], P[1], P[0]);
   or oGG0(GG, W33, W32, W31, G[3]);

endmodule // CLU_4bit

module CLU_2bit
  (
   input [1:0]  P,
   input [1:0]  G,
   input        Ci,
   output [2:1] Co,
   output       PG,
   output       GG
   );

   and a00(W00, P[0], Ci);
   or o00(C[1], W00, G[0]);

   and a10(W10, P[1], P[0], Ci);
   and a11(W11, P[1], G[0]);
   or o10(C[2], W11, W10, G[1]);

   and aPG0(PG, P[1], P[0]);
   or oGG0(GG, W11, G[1]);

endmodule // CLU_2bit
