`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.07.2025 14:49:03
// Design Name: 
// Module Name: nearest_40bit_matcher
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


module nearest_40bit_matcher (
    input wire clk,
    input wire reset,
    input wire start,
    input wire [159:0] input_vector,
    output reg [159:0] best_match,
    output reg done
);

    // Memory for 256 preloaded 160-bit patterns
    reg [159:0] patterns [0:255];
    initial begin $readmemb("160bit.mem", patterns);  // Should contain binary patterns
    end
    reg [7:0] index;
    reg [15:0] min_total_diff;
    reg [15:0] current_total_diff;
    reg [159:0] min_pattern;
    reg [159:0] best_pattern_temp;

    integer i;

    // FSM
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            index <= 0;
            min_total_diff <= 16'hFFFF;
            current_total_diff <= 0;
            min_pattern <= 0;
            best_match <= 0;
            best_pattern_temp<=0;
            done <= 0;
        end else if (start && !done) begin
            // Compute total absolute difference
            current_total_diff = 0;
            for (i = 0; i < 160; i = i + 1) begin
                if (input_vector[i] != patterns[index][i])
                    current_total_diff = current_total_diff + 1;
            end

            // Update minimum
            if (current_total_diff < min_total_diff) begin
                min_total_diff = current_total_diff;         // blocking assignment
                best_pattern_temp = patterns[index];
               
            end

            // Advance index
            if (index == 8'd255) begin
                best_match <= best_pattern_temp;
                done <= 1;
            end else begin
                index <= index + 1;
            end
        end
    end

endmodule
