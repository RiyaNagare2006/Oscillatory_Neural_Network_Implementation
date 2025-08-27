`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.07.2025 14:51:12
// Design Name: 
// Module Name: phase_alignment
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


module phase_alignment(
input sclk,nin,nout,re,
input [3:0]phi_out,
output reg [3:0]phase);

reg[3:0]diff_c_p;
reg[3:0]diff_c_n;
reg [2:0]state;

wire ein,eout;
wire [2:0]en={re,ein,eout};

edge_detector in(sclk,nin,ein);
edge_detector out(sclk,nout,eout);

parameter s0=0,s1=1,s2=2,s3=3,s4=4,s5=5;


always@(posedge sclk)
begin
if(re==1)
begin
state=s0;
phase<=phi_out;
end
else
begin
case(state)
s0:begin
    case(en)
    0:state=s0;
    1:state=s3;
    2:state=s1;
    3:state=s5;
    endcase
    end
    
s1:begin
        case(en)
        0:state=s1;
        1:state=s2;
        endcase
        end
        
s2:begin
         if(en==0)
         state=s0;
            end
            
s3:begin
        case(en)
        0:state=s3;
        2:state=s4;
        endcase
        end

s4:begin
        if(en==0)
        state=s0;
        end

s5:begin
        if(en==0)
          state=s0;
        end             
endcase
end
//end           
     
     
//always@(posedge sclk)
//begin
case(state)
s0:begin
   diff_c_p<=0;
   diff_c_n<=0;
   end
   
s1:begin
         diff_c_n<=diff_c_n+1;
      end
        
s2:begin
           
           if(diff_c_n>2)begin
            phase<=phi_out-diff_c_n;
            end
         end
           
s3:begin
               diff_c_p<=diff_c_p+1;
            end
             
s4:begin
            if(diff_c_p>2)begin
            phase<=phi_out+diff_c_p;
            end
            end
               
                 
s5:begin
            phase<=phi_out;
                  end
                  
endcase
                  
end

endmodule
