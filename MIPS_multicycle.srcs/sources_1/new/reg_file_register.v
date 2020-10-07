`timescale 1ns / 1ps

module reg_file_register # ( parameter WL = 32 )
(
    input CLK,
    input [WL - 1 : 0] RD1_in,
    input [WL - 1 : 0] RD2_in,
    output reg [WL - 1 : 0] A,
    output reg [WL - 1 : 0] B
);
    always @ (posedge CLK)
    begin
        A <= RD1_in;
        B <= RD2_in;
    end
endmodule
