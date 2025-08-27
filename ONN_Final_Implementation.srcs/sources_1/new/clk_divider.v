`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.07.2025 14:44:28
// Design Name: 
// Module Name: clk_divider
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



module clk_divider(
    input wire clk,             // Input clock (e.g., 100 MHz)
    output reg divided_clk = 0  // Output divided clock
);

    localparam div_value =  2; // Divide 100 MHz by (2 * 50M) to get 1 Hz
    integer counter_value = 0;

    // Counter for clock division
    always @(posedge clk) begin
        if (counter_value == div_value)
            counter_value <= 0; // Reset counter
        else
            counter_value <= counter_value + 1; // Count up
    end

    // Flip the output clock when counter reaches div_value
    always @(posedge clk) begin
        if (counter_value == div_value)
            divided_clk <= ~divided_clk; // Toggle the divided clock
        else
            divided_clk <= divided_clk;  // Hold current state
    end

endmodule