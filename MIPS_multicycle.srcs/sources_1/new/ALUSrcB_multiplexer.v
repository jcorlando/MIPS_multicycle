`timescale 1ns / 1ps

module ALUSrcB_multiplexer # ( parameter WL = 32 )
(
    input [1 : 0] ALUSrcB,
    input [WL - 1 : 0] B,
    input [WL - 1 : 0] SignImm,
    input [WL - 1 : 0] D,
    output reg [WL - 1 : 0] SrcB
);
    always @ (*)
    begin
    case(ALUSrcB)
      2'b00    : SrcB <= B;
      2'b01    : SrcB <= 1;
      2'b10    : SrcB <= SignImm;
      2'b11    : SrcB <= D;
      default  : SrcB <= 0;
    endcase
  end
    
    
endmodule
