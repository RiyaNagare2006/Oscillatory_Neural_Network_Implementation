`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.07.2025 14:43:45
// Design Name: 
// Module Name: top_onn_system
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


module top_onn_system(
    input  clk,
    input  reset,
    input  state_check,    
    input  [159:0] phi_out_in,   
    output reg [1:0] direction
);
    
    wire [39:0] state_changed_1ONN;
    wire [7:0]  state_changed_2ONN;
    wire [39:0] nout_1ONN;
    wire [39:0] nin_1ONN;
    wire [7:0]  nout_2ONN;
    wire [7:0]  nin_2ONN;
    wire slow_clk_out;
    wire [159:0] best_match_flat; 
    wire [31:0] best_match_2ONN;      // Flattened phi_out from 1ONN
    wire [31:0]  phi_out_input_flat_2ONN;
    
    wire slow_clk_1ONN;
    wire slow_clk_2ONN;
    
    wire [3:0] best_match_index;
    // Extract lowest 8 � 4 bits (32 bits) from best_match for the 2ONN
    assign phi_out_input_flat_2ONN = best_match_flat[31:0];

    // Expose slow_clk from 1ONN as output
    assign slow_clk_out = slow_clk_1ONN;
    
    wire match_ready_pulse_1ONN;
    reg [4:0] start_2ONN_counter = 0;
    wire start_2ONN;
    

    // Instantiate 1ONN
    onn_system_1ONN #(
        .N(40),
        .W(5)
    ) onn_1 (
        .clk(clk),
        .reset(reset),
        .state_check(state_check),
        .drop(1'b0),
        .phi_out_in(phi_out_in),
        .nout(nout_1ONN),
        .nin(nin_1ONN),
        .slow_clk(slow_clk_1ONN),
        .state_changed(state_changed_1ONN),
        .best_match(best_match_flat),
        .match_ready_pulse(match_ready_pulse_1ONN)
    );

always @(posedge slow_clk_1ONN or posedge reset) begin
    if (reset)
        start_2ONN_counter <= 0;
    else if (match_ready_pulse_1ONN)
        start_2ONN_counter <= 5'd5;
    else if (start_2ONN_counter != 0)
        start_2ONN_counter <= start_2ONN_counter - 1;
end

assign start_2ONN = (start_2ONN_counter != 0);

    // Instantiate 2ONN
    onn_system_2ONN #(
        .N(8),
        .W(5)
    ) onn_2 (
        .clk(clk),
        .reset(reset),
        .start(start_2ONN),
        .state_check(state_check),
        .drop(1'b0),
        .phi_out_input_flat(phi_out_input_flat_2ONN),
        .nout(nout_2ONN),
        .nin(nin_2ONN),
        .slow_clk(slow_clk_2ONN),
        .state_changed(state_changed_2ONN),
        .best_match(best_match_2ONN),
        .best_match_index(best_match_index)
    );

  // 2-bit: 00=Forward, 01=Left, 10=Right

always @(*) begin
    case (best_match_index)
        4'd1, 4'd0, 4'd14,4'd6: direction = 2'b01; // Forward
        4'd11, 4'd7, 4'd9, 4'd2, 4'd12: direction = 2'b10; // Left
        default: direction = 2'b11; // Right
    endcase
end



endmodule
