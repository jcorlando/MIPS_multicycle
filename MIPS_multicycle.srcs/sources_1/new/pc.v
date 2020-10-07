`timescale 1ns / 1ps

module pc # (  parameter WL = 32 )
(
    input CLK, EN,
    input [WL - 1 : 0] pc_In,
    output reg [WL - 1 : 0] pc_Out
);
    reg [WL - 1 : 0] pc;
    initial pc <= 512;
    always @ (*) pc_Out <= pc;
    always @ (posedge CLK) pc <= pc_In;
endmodule
