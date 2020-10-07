`timescale 1ns / 1ps

module inst_reg # ( parameter WL = 32 )
(
    input CLK, EN,
    input [WL - 1 : 0] instr_in,
    output [WL - 1 : 0] instr_out
);
    reg [WL - 1 : 0] instruction;
    initial instruction <= 0;
    
    wire [5 : 0] opcode = instruction[31 : 26];
    wire [4 : 0] rs = instruction[25 : 21];
    wire [4 : 0] rt = instruction[20 : 16];
    wire [4 : 0] rd = instruction[15 : 11];
    wire [15 : 0] Imm = instruction[15 : 0];
    wire [4 : 0] shamt = instruction[10 : 6];
    wire [5 : 0] funct = instruction[5 : 0];
    wire [25 : 0] Jaddr = instruction[25 : 0];
    wire signed [WL - 1 : 0] SImm = { {(WL - 16){Imm[15]}} ,Imm[15:0] };
    
    always @ (posedge CLK) if(EN) instruction <= instr_in;
    assign instr_out = instruction;
    
endmodule
