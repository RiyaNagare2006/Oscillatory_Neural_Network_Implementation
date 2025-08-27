`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.07.2025 14:47:27
// Design Name: 
// Module Name: clock_divider
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


module clock_divider(
    input wire clk,           // 100 MHz
    output reg divided_clk = 0
);

    localparam div_value = 16; // div value to convert clock frequency to 1 Hz
    integer counter_value = 0;

    // Keep counting until div_value
    always @(posedge clk) begin
        if (counter_value == div_value)
            counter_value <= 0;           // reset value
        else
            counter_value <= counter_value + 1; // count up
    end

    // Divide clock
    always @(posedge clk) begin
        if (counter_value == div_value)
            divided_clk <= ~divided_clk;  // flip the signal
        else
            divided_clk <= divided_clk;   // store value
    end

endmodule