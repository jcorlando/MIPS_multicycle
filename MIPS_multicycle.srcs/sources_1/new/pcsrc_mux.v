`timescale 1ns / 1ps

module pcsrc_mux # ( parameter WL = 32 )
(
    input [1 : 0] PCSrc,
    input [WL - 1 : 0] ALUResult,
    input [WL - 1 : 0] ALU_reg_out,
    input [WL - 1 : 0] PCJump,
    output reg [WL - 1 : 0] pc_In
);
    always @ (*)
    begin
        case(PCSrc)
            00:  pc_In <= ALUResult;
            01:  pc_In <= ALU_reg_out;
            10:  pc_In <= PCJump;
            default:  pc_In <= ALU_reg_out;
        endcase
    end
    
endmodule
