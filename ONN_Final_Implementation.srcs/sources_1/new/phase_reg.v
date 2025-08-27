`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.07.2025 14:52:38
// Design Name: 
// Module Name: phase_reg
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


module phase_reg(
    input re, clk, drop, state_check,
    input [3:0] ini_phase,
    input [3:0] phase,
    output reg [3:0] phi_out,
    output reg state_changed
);
always @(posedge clk or posedge re) begin
    if (re) begin
        phi_out <= ini_phase;
        state_changed <= 0;
    end else begin
        state_changed <= 0;
        case (1'b1)
            drop:        phi_out <= ini_phase;
            state_check: begin
                phi_out <= phase;
                state_changed <= |(phi_out ^ phase);
            end
            default:     phi_out <= phi_out;  // ? Explicit retention
        endcase
    end
end
endmodule