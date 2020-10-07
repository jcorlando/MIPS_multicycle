`timescale 1ns / 1ps

module testbench_MIPS_multicycle;
    parameter WL = 32, MEM_Depth = 1024;
    // Outputs
    wire [WL - 1 : 0] ram[0 : MEM_Depth - 1] = DUT.data_mem.ram;
    wire [WL - 1 : 0] rf[0 : 31] = DUT.reg_file.rf;
    
    // Instantiate DUT
    top # ( .WL(WL) ) DUT(  );                          // Clock
    // Clock generation
    always #10 DUT.CLK <= ~DUT.CLK;
    initial
    begin
        DUT.CLK <= 0;                                   // Clock
        @(posedge DUT.CLK);                             // Clock
        @(posedge DUT.CLK);                             // Clock
        @(posedge DUT.CLK);                             // Clock
        @(posedge DUT.CLK);                             // Clock
    end
    
endmodule
