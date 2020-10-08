`timescale 1ns / 1ps

module or_gate
(
    input and_out,
    input PCWrite,
    output PCEn
);
    
    assign PCEn = and_out | PCWrite; 
    
endmodule
