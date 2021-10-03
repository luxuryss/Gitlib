-- Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
-- Date        : Wed Sep 15 14:59:59 2021
-- Host        : LAPTOP-62TT0BEG running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub
--               D:/Software/Vivado/project/NET/net_test/net_test.runs/vio_cfg_synth_1/vio_cfg_stub.vhdl
-- Design      : vio_cfg
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7k325tffg900-2
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity vio_cfg is
  Port ( 
    clk : in STD_LOGIC;
    probe_in0 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    probe_out0 : out STD_LOGIC_VECTOR ( 0 to 0 );
    probe_out1 : out STD_LOGIC_VECTOR ( 0 to 0 );
    probe_out2 : out STD_LOGIC_VECTOR ( 0 to 0 );
    probe_out3 : out STD_LOGIC_VECTOR ( 31 downto 0 );
    probe_out4 : out STD_LOGIC_VECTOR ( 31 downto 0 );
    probe_out5 : out STD_LOGIC_VECTOR ( 0 to 0 );
    probe_out6 : out STD_LOGIC_VECTOR ( 31 downto 0 )
  );

end vio_cfg;

architecture stub of vio_cfg is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "clk,probe_in0[31:0],probe_out0[0:0],probe_out1[0:0],probe_out2[0:0],probe_out3[31:0],probe_out4[31:0],probe_out5[0:0],probe_out6[31:0]";
attribute X_CORE_INFO : string;
attribute X_CORE_INFO of stub : architecture is "vio,Vivado 2018.3";
begin
end;
