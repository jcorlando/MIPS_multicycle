`timescale 1ns / 1ps
module control_unit
(
    input CLK, RESET,
    input [5 : 0] Op,
    input [5 : 0] Funct,
    output reg MemtoReg,
    output reg RegDst,
    output reg IorD,
    output reg PCSrc,
    output reg [1 : 0] ALUSrcB,
    output reg ALUSrcA,
    output reg IRWrite,
    output reg MemWrite,
    output reg PCWrite,
    output Branch,
    output reg RegWrite,
    output reg [2 : 0] ALUControl
);
    localparam s0_fetch = 4'b0000, s1_decode = 4'b0001, s2_memadr = 4'b0010,
                 s3_memread = 4'b0011, s4_memwriteback = 4'b0100, s5_memwrite = 4'b0101,
                  s6_execute = 4'b0110,   s7_aluwriteback = 4'b0111;
    
    reg [2 : 0] current_state, next_state;
    
    initial current_state = s0_fetch;
    
//    state register with sync. reset
    always @ (posedge CLK)
    begin
        if(RESET) current_state <= s0_fetch;
        else current_state <= next_state;
    end
    
    
//    next state logic
//    use blocking assignments
    always @ (current_state or Op)
    begin
        case(current_state)
            s0_fetch:   // S0 fetch
            begin
                next_state = s1_decode;
            end
            s1_decode:  // s1 decode
            begin
                if(Op == 6'b100011 || Op == 6'b101011) next_state = s2_memadr;
                else if(Op == 6'b000000) next_state = s6_execute;
                else next_state = s0_fetch;
            end
            s2_memadr: // S2 
            begin
                if(Op == 6'b100011 ) next_state = s3_memread;
                else if(Op == 6'b101011 ) next_state = s5_memwrite;
                else next_state = s0_fetch;
            end
            s3_memread: // S3
            begin
                next_state = s4_memwriteback;
            end
            s4_memwriteback: // S4
            begin
                next_state = s0_fetch;
            end
            s5_memwrite: // S5
            begin
                next_state = s0_fetch;
            end
            s6_execute: // S6
            begin
                next_state = s7_aluwriteback;
            end
            s7_aluwriteback: // S7
            begin
                next_state = s0_fetch;
            end
            default next_state = s0_fetch;
        endcase
    end
    
    
//    output combinational logic
//    use blocking assignments
    always @ (current_state)
    begin
        case(current_state)
            s0_fetch:
            begin
                MemtoReg = 0;
                RegDst = 0;
                IorD = 0;
                ALUSrcA = 0;
                ALUSrcB = 2'b01;
                ALUControl = 3'b000;
                PCSrc = 0;
                IRWrite = 1;
                PCWrite = 1;
                RegWrite = 0;
                MemWrite = 0;
            end
            s1_decode:
            begin
                MemtoReg = 0;
                RegDst = 0;
                IRWrite = 0;
                PCWrite = 0;
                RegWrite = 0;
                MemWrite = 0;
            end
            
            s2_memadr:
            begin
                MemtoReg = 0;
                RegDst = 0;
                ALUSrcA = 1;
                ALUControl = 3'b000;
                ALUSrcB = 2'b10;
                IRWrite = 0;
                PCWrite = 0;
                RegWrite = 0;
                MemWrite = 0;
            end
            s3_memread:
            begin
                MemtoReg = 0;
                RegDst = 0;
                IorD = 1;
                IRWrite = 0;
                PCWrite = 0;
                RegWrite = 0;
                MemWrite = 0;
            end
            s4_memwriteback:
            begin
                RegDst = 0;
                MemtoReg = 1;
                RegWrite = 1;
                IRWrite = 0;
                PCWrite = 0;
                MemWrite = 0;
            end
            s5_memwrite:
            begin
                MemtoReg = 0;
                RegDst = 0;
                IorD = 1;
                MemWrite = 1;
            end
            s6_execute:
            begin
                MemtoReg = 0;
                RegDst = 0;
                ALUSrcA = 1;
                case(Funct)
                    32: ALUControl = 3'b000;
                    34: ALUControl = 3'b001;
                    0:
                    begin
                        top.shamt = top.inst_reg.shamt;
                        ALUControl = 3'b010;
                    end
                endcase
                ALUSrcB = 2'b00;
                IRWrite = 0;
                PCWrite = 0;
                RegWrite = 0;
                MemWrite = 0;
            end
            s7_aluwriteback:
            begin
                MemtoReg = 0;
                RegDst = 1;
                IRWrite = 0;
                PCWrite = 0;
                RegWrite = 1;
                MemWrite = 0;
            end
            default
            begin
                MemtoReg = 0;
                RegDst = 0;
                IorD = 0;
                ALUSrcA = 0;
                ALUSrcB = 2'b01;
                ALUControl = 3'b000;
                PCSrc = 0;
                IRWrite = 1;
                PCWrite = 1;
                RegWrite = 0;
                MemWrite = 0;
            end
        endcase
    end
    
    
    
    
    
    
    
    
    
    
    
    
    
endmodule
