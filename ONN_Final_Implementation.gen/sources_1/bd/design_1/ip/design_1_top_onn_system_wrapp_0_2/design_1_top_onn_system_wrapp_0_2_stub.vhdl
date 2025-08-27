-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2025.1 (win64) Build 6140274 Thu May 22 00:12:29 MDT 2025
-- Date        : Thu Jul  3 07:58:47 2025
-- Host        : LAPTOP-JP12RQ9T running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub
--               c:/Users/riyan/ONN_Final_Implementation/ONN_Final_Implementation.gen/sources_1/bd/design_1/ip/design_1_top_onn_system_wrapp_0_2/design_1_top_onn_system_wrapp_0_2_stub.vhdl
-- Design      : design_1_top_onn_system_wrapp_0_2
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7z020clg400-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity design_1_top_onn_system_wrapp_0_2 is
  Port ( 
    clk : in STD_LOGIC;
    reset : in STD_LOGIC;
    slow_clk : out STD_LOGIC;
    phi_0 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    phi_1 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    phi_2 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    phi_3 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    phi_4 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    direction : out STD_LOGIC_VECTOR ( 1 downto 0 )
  );

  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of design_1_top_onn_system_wrapp_0_2 : entity is "design_1_top_onn_system_wrapp_0_2,top_onn_system_wrapper,{}";
  attribute CORE_GENERATION_INFO : string;
  attribute CORE_GENERATION_INFO of design_1_top_onn_system_wrapp_0_2 : entity is "design_1_top_onn_system_wrapp_0_2,top_onn_system_wrapper,{x_ipProduct=Vivado 2025.1,x_ipVendor=xilinx.com,x_ipLibrary=module_ref,x_ipName=top_onn_system_wrapper,x_ipVersion=1.0,x_ipCoreRevision=1,x_ipLanguage=VERILOG,x_ipSimLanguage=MIXED}";
  attribute DowngradeIPIdentifiedWarnings : string;
  attribute DowngradeIPIdentifiedWarnings of design_1_top_onn_system_wrapp_0_2 : entity is "yes";
  attribute IP_DEFINITION_SOURCE : string;
  attribute IP_DEFINITION_SOURCE of design_1_top_onn_system_wrapp_0_2 : entity is "module_ref";
end design_1_top_onn_system_wrapp_0_2;

architecture stub of design_1_top_onn_system_wrapp_0_2 is
  attribute syn_black_box : boolean;
  attribute black_box_pad_pin : string;
  attribute syn_black_box of stub : architecture is true;
  attribute black_box_pad_pin of stub : architecture is "clk,reset,slow_clk,phi_0[31:0],phi_1[31:0],phi_2[31:0],phi_3[31:0],phi_4[31:0],direction[1:0]";
  attribute X_INTERFACE_INFO : string;
  attribute X_INTERFACE_INFO of clk : signal is "xilinx.com:signal:clock:1.0 clk CLK";
  attribute X_INTERFACE_MODE : string;
  attribute X_INTERFACE_MODE of clk : signal is "slave";
  attribute X_INTERFACE_PARAMETER : string;
  attribute X_INTERFACE_PARAMETER of clk : signal is "XIL_INTERFACENAME clk, FREQ_HZ 50000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN design_1_processing_system7_0_0_FCLK_CLK0, INSERT_VIP 0";
  attribute X_INTERFACE_INFO of reset : signal is "xilinx.com:signal:reset:1.0 reset RST";
  attribute X_INTERFACE_MODE of reset : signal is "slave";
  attribute X_INTERFACE_PARAMETER of reset : signal is "XIL_INTERFACENAME reset, POLARITY ACTIVE_LOW, INSERT_VIP 0";
  attribute X_INTERFACE_INFO of slow_clk : signal is "xilinx.com:signal:clock:1.0 slow_clk CLK";
  attribute X_INTERFACE_MODE of slow_clk : signal is "master";
  attribute X_INTERFACE_PARAMETER of slow_clk : signal is "XIL_INTERFACENAME slow_clk, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN design_1_top_onn_system_wrapp_0_2_slow_clk, INSERT_VIP 0";
  attribute X_CORE_INFO : string;
  attribute X_CORE_INFO of stub : architecture is "top_onn_system_wrapper,Vivado 2025.1";
begin
end;
