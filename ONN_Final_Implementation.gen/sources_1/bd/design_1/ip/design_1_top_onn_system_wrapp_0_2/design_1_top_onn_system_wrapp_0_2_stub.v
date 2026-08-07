// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2025.1 (win64) Build 6140274 Thu May 22 00:12:29 MDT 2025
// Date        : Thu Jul  3 07:58:47 2025
// Host        : LAPTOP-JP12RQ9T running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               c:/Users/riyan/ONN_Final_Implementation/ONN_Final_Implementation.gen/sources_1/bd/design_1/ip/design_1_top_onn_system_wrapp_0_2/design_1_top_onn_system_wrapp_0_2_stub.v
// Design      : design_1_top_onn_system_wrapp_0_2
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7z020clg400-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* CHECK_LICENSE_TYPE = "design_1_top_onn_system_wrapp_0_2,top_onn_system_wrapper,{}" *) (* CORE_GENERATION_INFO = "design_1_top_onn_system_wrapp_0_2,top_onn_system_wrapper,{x_ipProduct=Vivado 2025.1,x_ipVendor=xilinx.com,x_ipLibrary=module_ref,x_ipName=top_onn_system_wrapper,x_ipVersion=1.0,x_ipCoreRevision=1,x_ipLanguage=VERILOG,x_ipSimLanguage=MIXED}" *) (* DowngradeIPIdentifiedWarnings = "yes" *) 
(* IP_DEFINITION_SOURCE = "module_ref" *) (* X_CORE_INFO = "top_onn_system_wrapper,Vivado 2025.1" *) 
module design_1_top_onn_system_wrapp_0_2(clk, reset, slow_clk, phi_0, phi_1, phi_2, phi_3, 
  phi_4, direction)
/* synthesis syn_black_box black_box_pad_pin="reset,slow_clk,phi_0[31:0],phi_1[31:0],phi_2[31:0],phi_3[31:0],phi_4[31:0],direction[1:0]" */
/* synthesis syn_force_seq_prim="clk" */;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 clk CLK" *) (* X_INTERFACE_MODE = "slave" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME clk, FREQ_HZ 50000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN design_1_processing_system7_0_0_FCLK_CLK0, INSERT_VIP 0" *) input clk /* synthesis syn_isclock = 1 */;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 reset RST" *) (* X_INTERFACE_MODE = "slave" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME reset, POLARITY ACTIVE_LOW, INSERT_VIP 0" *) input reset;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 slow_clk CLK" *) (* X_INTERFACE_MODE = "master" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME slow_clk, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN design_1_top_onn_system_wrapp_0_2_slow_clk, INSERT_VIP 0" *) output slow_clk;
  input [31:0]phi_0;
  input [31:0]phi_1;
  input [31:0]phi_2;
  input [31:0]phi_3;
  input [31:0]phi_4;
  output [1:0]direction;
endmodule
