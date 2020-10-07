`timescale 1ns / 1ps

module alu_out_register # ( parameter WL = 32 )
(
    input CLK,
    input signed [WL - 1 : 0] ALU_reg_in,
    output reg signed [WL - 1 : 0] ALU_reg_out
);
    
    always @ (posedge CLK)
    begin
        ALU_reg_out <= ALU_reg_in;
    end
    
endmodule
