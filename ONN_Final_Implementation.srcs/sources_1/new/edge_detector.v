`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.07.2025 14:52:01
// Design Name: 
// Module Name: edge_detector
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


module edge_detector (
    input wire clk,
    input wire signal,
    output reg rising_edge
);
    reg signal_d;

    always @(posedge clk) begin
        signal_d <= signal;
        rising_edge <= signal & ~signal_d; // detect rising edge
    end
endmodule