`timescale 1ns / 1ps

module memtoreg_mux # ( parameter WL = 32 )
(
    input MemtoReg,
    input [WL - 1 : 0] ALU_reg_out,
    input [WL - 1 : 0] Data,
    output reg [WL - 1 : 0] WD3
);
    
    always @ (*)
    begin
        if(MemtoReg) WD3 <= Data;
        else WD3 <= ALU_reg_out;
    end
    
endmodule
