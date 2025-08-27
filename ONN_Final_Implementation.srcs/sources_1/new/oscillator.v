`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.07.2025 14:49:55
// Design Name: 
// Module Name: oscillator
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



module oscillator (
    input wire clk,              // Main clock
    input wire reset,            // Active-high reset
    input wire slow_clk,         // Slower clock for oscillation steps
    input wire [3:0] phi_out,    // 4-bit phase pointer (0-15)
    output wire nout             // Output based on current phase
);

    // 16-bit shift register
    reg [15:0] shift_reg;
 
    // Initialize shift register or rotate it on slow clock
    always @(posedge slow_clk or posedge reset) begin
        if (reset)
            shift_reg <= 16'b1111111100000000; // Square wave: 8 high, 8 low
            
        else
            shift_reg <= {shift_reg[14:0], shift_reg[15]}; // Circular left shift
    end

    // MUX: output the bit at position phi_out
    assign nout = shift_reg[phi_out];

endmodule