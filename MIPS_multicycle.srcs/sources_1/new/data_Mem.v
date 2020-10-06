`timescale 1ns / 1ps

module data_Mem # ( parameter WL = 32, MEM_Depth = 1024 )
(
    input CLK, WE,
    input signed [WL - 1 : 0] A,
    input [WL - 1 : 0] WD,
    output [WL - 1 : 0] RD
);
    
    reg [WL - 1 : 0] ram[0 : MEM_Depth - 1];
    initial $readmemh("my_Data_Memory.mem", ram);
    
    assign RD = ram[A[WL - 1 : 0]];                     // Word Aligned
    
    always @ (posedge CLK)
    if (WE) ram[A[WL - 1 : 0]] <= WD;                   // Word Aligned
    
    
endmodule


