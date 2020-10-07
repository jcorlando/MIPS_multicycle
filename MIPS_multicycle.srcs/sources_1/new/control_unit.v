`timescale 1ns / 1ps
module control_unit
(
    input CLK,
    input [5 : 0] Op,
    input [5 : 0] Funct,
    output MemtoReg,
    output RegDst,
    output IorD,
    output PCSrc,
    output [1 : 0] ALUSrcB,
    output ALUSrcA,
    output IRWrite,
    output MemWrite,
    output PCWrite,
    output Branch,
    output RegWrite,
    output [2 : 0] ALUControl
);
    
    
    localparam s0_fetch = 3'b000, s1_decode = 3'b001, s2_memadr = 3'b010,
                s3_memread = 3'b011, s4_memwriteback = 3'b100;
    
    
//    state register with sync. reset
//    always @ (posedge CLK)
    
    
//    next state combinational logic
//    use blocking assignments
//    always @ ()
    
    
//    output combinational logic
//    use blocking assignments
//    always @ (current state)
    
    
    
    
    
    
    
endmodule
