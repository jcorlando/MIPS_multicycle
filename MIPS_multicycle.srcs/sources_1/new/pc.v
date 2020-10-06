`timescale 1ns / 1ps

module pc # (  parameter WL = 32 )
(
    input CLK, EN,
    input [WL - 1 : 0] pc_In,
    output reg [WL - 1 : 0] pc_Out
);
    reg [WL - 1 : 0] pc;
    always @ (*) pc = pc_In;
    
    initial pc_Out <= 0;
    always @ (posedge CLK) pc_Out <= pc_In;
endmodule
