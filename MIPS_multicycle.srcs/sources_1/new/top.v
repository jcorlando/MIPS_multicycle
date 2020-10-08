`timescale 1ns / 1ps

module top # ( parameter WL = 32 )
(
    
);
    reg CLK;
    reg RESET;
    reg [4 : 0] shamt;
    wire MemWrite;
    wire IRWrite;
    wire IorD;
    wire RegWrite;
    wire [2 : 0] ALUControl;
    wire ALUSrcA;
    wire [1 : 0] ALUSrcB;
    wire PCWrite;
    wire [1 : 0] PCSrc;
    wire RegDst;
    wire MemtoReg;
    wire Branch;
    
    
    wire [WL - 1 : 0] pc_Out;
    wire [WL - 1 : 0] RD;
    wire [WL - 1 : 0] instr_out;
    wire [WL - 1 : 0] RD1;
    wire [WL - 1 : 0] RD2;
    wire [WL - 1 : 0] A;
    wire [WL - 1 : 0] B;
    wire signed [WL - 1 : 0] SImm = inst_reg.SImm;
    wire [25 : 0] Jaddr = inst_reg.Jaddr;
    wire [WL - 1 : 0] PCJump = { pc_Out[31 : 26], Jaddr };
    wire signed [WL - 1 : 0] ALUResult;
    wire [WL - 1 : 0] Adr;
    wire signed [WL - 1 : 0] ALU_reg_out;
    wire [WL - 1 : 0] Data;
    wire [WL - 1 : 0] SrcA;
    wire [WL - 1 : 0] SrcB;
    wire [4 : 0] A3;
    wire [WL - 1 : 0] WD3;
    wire PCEn;
    wire and_out;
    wire zero;
    wire [WL - 1 : 0] pc_In;
    
    
    
    // Control Unit
    control_unit cont_unit( .CLK(CLK), .RESET(RESET), .Op(inst_reg.opcode), .Funct(inst_reg.funct), .ALUSrcA(ALUSrcA),  // Control Unit
                   .ALUSrcB(ALUSrcB), .IorD(IorD), .ALUControl(ALUControl), .PCSrc(PCSrc), .IRWrite(IRWrite),           // Control Unit
                        .PCWrite(PCWrite), .RegWrite(RegWrite), .MemWrite(MemWrite), .RegDst(RegDst),                   // Control Unit
                               .MemtoReg(MemtoReg), .Branch(Branch) );                                                  // Control Unit
    // Control Unit
    
    
    // PC Gates
    and_gate and_gate( .Branch(Branch), .zero(zero), .and_out(and_out) );                                    // PC Gates
    or_gate or_gate( .and_out(and_out), .PCWrite(PCWrite), .PCEn(PCEn) );                          // PC Gates
    // PC Gates
    
    // program counter
    pc pc( .CLK(CLK), .EN(PCEn), .pc_In(pc_In), .pc_Out(pc_Out) );                                // program counter
    // program counter
    
    // program counter multiplexer
    IorD_multiplexer IorD_multiplex(.IorD(IorD), .in0(pc_Out), .in1(ALU_reg_out), .out(Adr) );           // program counter multiplexer
    // program counter multiplexer
    
    // Data Memory
    data_Mem data_mem( .CLK(CLK), .WE(MemWrite), .A(Adr), .RD(RD), .WD(B) );                             // Data Memory
    // Data Memory
    
    // Instruction Register
    inst_reg inst_reg( .CLK(CLK), .EN(IRWrite), .instr_in(RD), .instr_out(instr_out) );                     // Instruction Register
    // Instruction Register
    
    // data register
    data_register data_register( .CLK(CLK), .RD(RD), .Data(Data) );                                         // data register
    // data register
    
    // RegDst Mux
    regdst_mux regdst_mux( .RegDst(RegDst), .rt(inst_reg.rt), .rd(inst_reg.rd), .A3(A3) );                  // RegDst Mux
    // RegDst Mux
    
    // MemtoReg mux
    memtoreg_mux memtoreg_mux(.MemtoReg(MemtoReg), .ALU_reg_out(ALU_reg_out), .Data(Data), .WD3(WD3) );     // MemtoReg mux
    // MemtoReg mux
    
    // Register File
    reg_File reg_file( .CLK(CLK), .WE3(RegWrite), .A1(inst_reg.rs), .A2(inst_reg.rt), .WD3(WD3),          // Register File
                    .A3(A3), .RD1(RD1), .RD2(RD2) );                                                        // Register File
    // Register File
    
    // Register File register
    reg_file_register  reg_file_reg( .CLK(CLK), .RD1_in(RD1), .RD2_in(RD2), .A(A), .B(B) );                // Register File register
    // Register File register
    
    // ALUSrcA multiplexer
    ALUSrcA_multiplexer ALUSrcA_multiplexer( .ALUSrcA(ALUSrcA), .PC(pc_Out), .A(A), .SrcA(SrcA) );              // ALUSrcA multiplexer
    // ALUSrcA multiplexer
    
    // ALUSrcB multiplexer
    ALUSrcB_multiplexer ALUSrcB_multiplexer( .ALUSrcB(ALUSrcB), .B(B), .SignImm(SImm), .D(SImm), .SrcB(SrcB) );     // ALUSrcB multiplexer
    // ALUSrcB multiplexer
    
    // ALU
    alu alu( .zero(zero), .shamt(shamt), .A(SrcA), .B(SrcB), .ALU_Control(ALUControl), .ALU_Out(ALUResult) );           // ALU
    // ALU
    
    // ALU register
    alu_out_register alu_out_reg( .CLK(CLK), .ALU_reg_in(ALUResult), .ALU_reg_out(ALU_reg_out) );                           // ALU register
    // ALU register
    
    // PCSrc Mux
    pcsrc_mux pcsrc_mux(.PCSrc(PCSrc), .ALUResult(ALUResult), .ALU_reg_out(ALU_reg_out), .PCJump(PCJump), .pc_In(pc_In) );  // PCSrc Mux
    // PCSrc Mux
    
endmodule



























