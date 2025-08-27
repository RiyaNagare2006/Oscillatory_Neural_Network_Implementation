`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.07.2025 08:22:13
// Design Name: 
// Module Name: iobuf_wrapper
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module iobuf_wrapper (
    input wire i,
    output wire o,
    input wire t,
    inout wire io
);
    IOBUF iobuf_inst (
        .I(i),
        .O(o),
        .T(t),
        .IO(io)
    );
endmodule
