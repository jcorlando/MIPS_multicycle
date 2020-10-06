`timescale 1ns / 1ps

module inst_reg # ( parameter WL = 32 )
(
    input CLK, EN,
    input [WL - 1 : 0] instr_in,
    output [WL - 1 : 0] instr_out
);
    reg [WL - 1 : 0] instruction;
    initial instruction <= 0;
    
    always @ (posedge CLK) if(EN) instruction <= instr_in;
    assign instr_out = instruction;
    
endmodule
