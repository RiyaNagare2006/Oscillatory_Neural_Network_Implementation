`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.07.2025 14:55:36
// Design Name: 
// Module Name: top_onn_system_tb
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


module top_onn_system_tb;

    // Inputs
    reg clk;
    reg reset;
   
    wire slow_clk;
    wire [1:0] direction;
    reg  phi_bit;
    // Outputs
    
    // Instantiate the top module
    top_onn_system_wrapper uut (
        .clk(clk),
        .reset(reset),
      
        .slow_clk(slow_clk),
        .direction(direction),
        
        .phi_bit(phi_bit)
        
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 100 MHz clock
    end

    // Stimulus logic
   initial begin
    reset = 1;
     
       

        // Set phi_out_in_tb (example: set specific oscillators to phase 4'b1111)
        phi_bit = 1;  // default: all 0000
        #1000;
        reset=1;
      
        #1000 
        #100;

        
        #10 
        #500;

        reset = 1;
     
        #1000;

        reset = 0;
        #100;
    
        #1000 
        #100;
        
        repeat (30) begin
          
            #1000;

        end
        
    end



endmodule
