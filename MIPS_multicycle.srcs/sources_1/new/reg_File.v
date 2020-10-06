`timescale 1ns / 1ps

module reg_File # (parameter WL = 32)
(
    input CLK,
    input WE3,
    input [4 : 0] A1, A2, A3,
    input [WL - 1 : 0] WD3,
    output [WL - 1 : 0] RD1, RD2
);
    reg [WL - 1 : 0] rf[0 : 31];
    
    initial $readmemh("my_Reg_Memory.mem", rf);         // Initialize Register File
    assign RD1 = rf[A1];                                // Read First Mode
    assign RD2 = rf[A2];                                // Read First Mode
    
    always @ (posedge CLK)
    begin
        if (WE3) begin rf[A3] <= WD3; end
    end
endmodule

