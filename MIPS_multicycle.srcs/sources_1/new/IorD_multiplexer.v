`timescale 1ns / 1ps

module IorD_multiplexer # ( parameter WL = 32 )
(
    input IorD,
    input [WL - 1 : 0] in0,
    input [WL - 1 : 0] in1,
    output reg [WL - 1 : 0] out
);
    
    always @ (*)
    begin
        if(IorD == 0) out <= in0;
        else out <= in1;
    end
    
endmodule
