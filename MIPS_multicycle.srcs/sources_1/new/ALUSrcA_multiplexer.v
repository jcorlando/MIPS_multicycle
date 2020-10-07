`timescale 1ns / 1ps

module ALUSrcA_multiplexer # ( parameter WL = 32 )
(
    input ALUSrcA,
    input [WL - 1 : 0] PC,
    input [WL - 1 : 0] A,
    output reg [WL - 1 : 0] SrcA
);
    always @ (*)
    begin
        if(ALUSrcA == 0) SrcA <= PC;
        else SrcA <= A;
    end
    
    
endmodule
