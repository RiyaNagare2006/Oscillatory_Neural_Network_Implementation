`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.07.2025 14:54:09
// Design Name: 
// Module Name: nearest_8bit_matcher
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

module nearest_8bit_matcher (
    input wire clk,
    input wire reset,
    input wire start,
    input wire [31:0] input_vector,
    output reg [31:0] best_match,
    output reg done,
    output reg [3:0] best_match_index

);

    // Memory for 16 preloaded 32-bit patterns
    reg [31:0] patterns [0:15];
    initial begin 
    $readmemb("32bit.mem", patterns);  // 16 patterns of 32 bits each
    end
    reg [3:0] index;  // 4-bit index for 16 patterns
    reg [5:0] min_total_diff;        // Max diff = 32
    reg [5:0] current_total_diff;
    reg [31:0] best_pattern_temp;    // Best matched pattern
    reg [3:0] best_index_temp;       // Index of best match

    integer i;

    // FSM
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            index <= 0;
            min_total_diff <= 6'h3F;          
            best_pattern_temp <= 0;
            best_index_temp <= 0;
            current_total_diff <= 0;
            
            best_match <= 0;
            done <= 0;
        end else if (start && !done) begin
            current_total_diff = 0;

            for (i = 0; i < 32; i = i + 1) begin
                if (input_vector[i] != patterns[index][i])
                    current_total_diff = current_total_diff + 1;
            end

            if (current_total_diff < min_total_diff) begin
                    min_total_diff = current_total_diff;
                best_pattern_temp = patterns[index];
                best_index_temp = index;
                    
            end
            
            
            if (index == 4'd15) begin
                    best_match <= best_pattern_temp;
                best_match_index <= best_index_temp;
                done <= 1;
            end
            else begin
                index <= index + 1;
            end
        end
    end

endmodule
