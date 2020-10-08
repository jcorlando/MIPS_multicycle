`timescale 1ns / 1ps

module regdst_mux
(
    input RegDst,
    input [4 : 0] rt,
    input [4 : 0] rd,
    output reg [4 : 0] A3
);
    always @ (*)
    begin
        if(RegDst) A3 <= rd;
        else A3 <= rt;
    end
    
endmodule
