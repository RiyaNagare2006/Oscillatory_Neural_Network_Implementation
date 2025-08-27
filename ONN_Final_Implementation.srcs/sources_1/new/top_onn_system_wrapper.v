`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.07.2025 14:42:45
// Design Name: 
// Module Name: top_onn_system_wrapper
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
module top_onn_system_wrapper (
    input wire clk,
    input wire reset,
    output wire slow_clk,
    input wire [31:0] phi_0,
    input wire [31:0] phi_1,
    input wire [31:0] phi_2,
    input wire [31:0] phi_3,
    input wire [31:0] phi_4,
    output wire [1:0] direction
);

    // Concatenate all 5 x 32-bit inputs into one 160-bit wire
    wire [159:0] phi_out_in;
    assign phi_out_in = {phi_4, phi_3, phi_2, phi_1, phi_0};

    // Slow clock divider instantiation
    clk_divider clk_div(
        .clk(clk),
        .divided_clk(slow_clk)
    ); 

    // Instantiate the core system
    top_onn_system riya (
        .clk(clk),
        .reset(reset),
        .state_check(1'b1),
        .phi_out_in(phi_out_in),
        .direction(direction)
    );
endmodule

