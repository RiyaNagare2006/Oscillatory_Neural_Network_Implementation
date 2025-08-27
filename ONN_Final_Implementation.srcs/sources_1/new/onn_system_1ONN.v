`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.07.2025 14:45:19
// Design Name: 
// Module Name: onn_system_1ONN
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


module onn_system_1ONN #(
    parameter N = 40,
    parameter W = 5
)(
    input clk,
    input reset,
    input state_check,
    input drop,
    input [4*N-1:0] phi_out_in,
    output wire [N-1:0] nout,
    output wire [N-1:0] nin,
    output slow_clk,
    output wire [N-1:0]state_changed,
    output wire [159:0] best_match,
    output wire match_ready_pulse

);  

    wire divided_clk;
    reg [3:0] phi_out [N-1:0];           // current phase output for each oscillator
    wire [3:0] phi_from_reg [N-1:0];     // updated phase from phase_reg
    wire [3:0] phase_internal [N-1:0];   // computed phase
    

    clock_divider clk_div1(
        .clk(clk),
        .divided_clk(divided_clk)
    );
    
    clk_divider clk_div(
        .clk(divided_clk),
        .divided_clk(slow_clk)
    ); 

    integer i;
    always@(posedge slow_clk) begin
        if (reset) begin
            for (i = 0; i < N; i = i + 1)
                phi_out[i] <= phi_out_in[i*4 +: 4];
            end else begin
            for (i = 0; i < N; i = i + 1)
                phi_out[i] <= phi_from_reg[i];
        end
    end
    // Generate oscillators
    genvar g;
    generate
        for (g = 0; g < N; g = g + 1) begin : gen_osc
           
            oscillator os(
                .clk(divided_clk),
                .reset(reset),
                .slow_clk(slow_clk),
                .phi_out(phi_out[g]),
                .nout(nout[g])
            );
        end
    endgenerate
    
    
    
    // Declare a 2D weight matrix (signed)
    reg signed [W-1:0] weights_1d [0:N*N-1];
    
    integer k;
    
    initial begin
        $readmemb("maybe_final.mem", weights_1d);
    end
    // You can initialize this matrix using another module or from memory
    
    wire signed [(N*N*W)-1:0] weights_flat;

    genvar kdx;
    generate
        for (kdx = 0; kdx < N*N; kdx = kdx + 1) begin : pack_weights
            assign weights_flat[kdx*W +: W] = weights_1d[kdx];  // LSB-first
        end
    endgenerate
    
    reg compute_once_flag;
    


    compute_nin nin_inst (
    .clk(slow_clk),
    .nouts(nout),
    .weights_flat(weights_flat),
    .nin(nin)
    );

    
    
    // Generate phase alignment and phase registers
    generate
        for (g = 0; g < N; g = g + 1) begin : gen_align_reg
            phase_alignment ph(
                .sclk(slow_clk),
                .nin(nin[g]),
                .nout(nout[g]),
                .re(reset),
                .phi_out(phi_out[g]),
                .phase(phase_internal[g])
            );
            
            phase_reg phase_reg_inst(
                .re(reset),
                .clk(slow_clk),
                .drop(drop),
                .state_check(state_check),
                .ini_phase(phi_out[g]),
                .phase(phase_internal[g]),
             
                .phi_out(phi_from_reg[g]),
                .state_changed(state_changed[g])
            );
        end
    endgenerate
    
wire [159:0] phi_out_flat;

genvar r;
generate
    for (r = 0; r < N; r = r + 1) begin : flatten_phi
        assign phi_out_flat[r*4 +: 4] = phi_out[r];  // Packs MSB first
    end
endgenerate

reg [5:0] zero_counter;              // Can count up to at least 30
reg stable_flag;
localparam [5:0] THRESHOLD = 6'd30;

always @(posedge slow_clk or posedge reset) begin
    if (reset) begin
        zero_counter <= 0;
        stable_flag <= 0;
    end else begin
        if (|state_changed) begin
            // Any neuron changed ? reset count
            zero_counter <= 0;
            stable_flag <= 0;
        end else begin
            // All neurons stable
            if (zero_counter < THRESHOLD - 1) begin
                zero_counter <= zero_counter + 1;
                stable_flag <= 0;
            end else begin
                zero_counter <= zero_counter;  // Hold at THRESHOLD
                stable_flag <= 1;              // Now stable
            end
        end
    end
end

wire done;

reg start_match;
always @(posedge slow_clk or posedge reset) begin
    if (reset) begin
        start_match <= 0;
    end else if (stable_flag) begin
        start_match <= 1;
    end else begin
        start_match <= 0;
    end
end

nearest_40bit_matcher matcher_inst (
    .clk(clk),
    .reset(reset),
    .start(start_match),
    .input_vector(phi_out_flat),
    .best_match(best_match),
    .done(done)
);

reg done_d;
always @(posedge slow_clk or posedge reset) begin
    if (reset)
        done_d <= 0;
    else
        done_d <= done;
end

assign match_ready_pulse = done & ~done_d;  // 1-cycle pulse

        
endmodule




