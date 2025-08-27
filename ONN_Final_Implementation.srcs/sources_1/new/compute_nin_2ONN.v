`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.07.2025 14:53:27
// Design Name: 
// Module Name: compute_nin_2ONN
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


module compute_nin_2ONN #(
    parameter N = 8,
    parameter W = 5
)(
    input wire clk,
    input wire [N-1:0] nouts,
    input wire signed [(N*N*W)-1:0] weights_flat,
    output reg [N-1:0] nin
);

    integer i, j;
    reg signed [W+N-1:0] sum;
    reg signed [W-1:0] weight;

    always @(posedge clk) begin
      
            for (i = 0; i < N; i = i + 1) begin
                sum = 0;
                for (j = 0; j < N; j = j + 1) begin
                    if (i != j) begin
                        weight = $signed(weights_flat[W*(i*N + j) +: W]);
                        sum = sum + ((nouts[j]) ? weight : -weight);
                    end
                end
                nin[i] <= (sum > 0) ? 1'b1 : 1'b0;
            end
    end
endmodule
