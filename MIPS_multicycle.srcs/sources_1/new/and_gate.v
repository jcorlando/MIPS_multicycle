`timescale 1ns / 1ps

module and_gate
(
    input Branch,
    input zero,
    output and_out
);
    assign and_out = Branch & zero;
endmodule
