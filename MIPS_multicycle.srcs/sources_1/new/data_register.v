`timescale 1ns / 1ps

module data_register # ( parameter WL = 32 )
(
    input CLK,
    input  [WL - 1 : 0] RD,
    output reg [WL - 1 : 0] Data
);
    always @ ( posedge CLK )
    begin
        Data <= RD;
    end
endmodule
