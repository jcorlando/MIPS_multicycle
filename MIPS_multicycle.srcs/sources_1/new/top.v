`timescale 1ns / 1ps

module top # ( parameter WL = 32 )
(
    
);
    reg CLK;
    wire MemWrite;
    wire IorD;
    wire IRWrite;
    wire RegWrite;
    wire ALUSrcA;
    wire [1 : 0] ALUSrcB;
    
    
    wire [WL - 1 : 0] pc_Out;
    wire [WL - 1 : 0] RD;
    wire [WL - 1 : 0] instr_out;
    wire [WL - 1 : 0] RD1;
    wire [WL - 1 : 0] A;
    wire signed [WL - 1 : 0] SImm = inst_reg.SImm;
    wire signed [WL - 1 : 0] ALUResult;
    wire [WL - 1 : 0] Adr;
    wire signed [WL - 1 : 0] ALU_reg_out;
    wire [WL - 1 : 0] Data;
    wire [WL - 1 : 0] SrcA;
    wire [WL - 1 : 0] SrcB;
    
    
    // Control Unit
    control_unit cont_unit( .CLK(CLK), .Op(inst_reg.opcode), .Funct(inst_reg.funct), .ALUSrcB(ALUSrcB)          // Control Unit
                   );                      // Control Unit
    // Control Unit
    
    // program counter
    pc pc( .CLK(CLK), .pc_In(ALUResult), .pc_Out(pc_Out) );                                                              // program counter
    // program counter
    
    // program counter multiplexer
    IorD_multiplexer IorD_multiplex(.IorD(IorD), .in0(pc_Out), .in1(ALU_reg_out), .out(Adr) );                  // program counter multiplexer
    // program counter multiplexer
    
    // Data Memory
    data_Mem data_mem( .CLK(CLK), .WE(IRWrite), .A(Adr), .RD(RD) );                                             // Data Memory
    // Data Memory
    
    // Instruction Register
    inst_reg inst_reg( .CLK(CLK), .EN(), .instr_in(RD), .instr_out(instr_out) );                                // Instruction Register
    // Instruction Register
    
    // data register
    data_register data_register( .CLK(CLK), .RD(RD), .Data(Data) );                                             // data register
    // data register
    
    // Register File
    reg_File reg_file( .CLK(CLK), .WE3(RegWrite), .A1(instr_out), .WD3(Data),                                   // Register File
                    .A3(inst_reg.rt), .RD1(RD1) );                                                              // Register File
    // Register File
    
    // Register File register
    reg_file_register  reg_file_reg( .CLK(CLK), .RD1_in(RD1), .A(A) );                                          // Register File register
    // Register File register
    
    // ALUSrcA multiplexer
    ALUSrcA_multiplexer ALUSrcA_multiplexer( .ALUSrcA(ALUSrcA), .PC(pc_Out), .A(A), .SrcA(SrcA) );              // ALUSrcA multiplexer
    // ALUSrcA multiplexer
    
    // ALUSrcB multiplexer
    ALUSrcB_multiplexer ALUSrcB_multiplexer( .ALUSrcB(ALUSrcB), .A(), .SignImm(SImm), .D(), .SrcB(SrcB) );      // ALUSrcB multiplexer
    // ALUSrcB multiplexer
    
    // ALU
    alu alu( .A(SrcA), .B(SrcB), .ALU_Control(), .ALU_Out(ALUResult) );                                         // ALU
    // ALU
    
    // ALU register
    alu_out_register alu_out_reg( .CLK(CLK), .ALU_reg_in(ALUResult), .ALU_reg_out(ALU_reg_out) );               // ALU register
    // ALU register
    
endmodule



























