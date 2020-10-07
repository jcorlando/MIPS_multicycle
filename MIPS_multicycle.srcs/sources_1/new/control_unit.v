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
    localparam s0_fetch = 3'b000, s1_decode = 3'b001, s2_memadr = 3'b010,
                s3_memread = 3'b011, s4_memwriteback = 3'b100;
    
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
                else next_state = s0_fetch;
            end
            s2_memadr: // S2 
            begin
                if(Op == 6'b100011 ) next_state = s3_memread;
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
                
                IRWrite = 0;
                PCWrite = 0;
                RegWrite = 0;
                MemWrite = 0;
            end
            
            s2_memadr:
            begin
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
        endcase
    end
    
    
    
    
    
    
    
    
    
    
    
    
    
endmodule
