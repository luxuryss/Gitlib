// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
// Date        : Wed Sep 15 14:59:59 2021
// Host        : LAPTOP-62TT0BEG running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               D:/Software/Vivado/project/NET/net_test/net_test.runs/vio_cfg_synth_1/vio_cfg_stub.v
// Design      : vio_cfg
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7k325tffg900-2
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* X_CORE_INFO = "vio,Vivado 2018.3" *)
module vio_cfg(clk, probe_in0, probe_out0, probe_out1, 
  probe_out2, probe_out3, probe_out4, probe_out5, probe_out6)
/* synthesis syn_black_box black_box_pad_pin="clk,probe_in0[31:0],probe_out0[0:0],probe_out1[0:0],probe_out2[0:0],probe_out3[31:0],probe_out4[31:0],probe_out5[0:0],probe_out6[31:0]" */;
  input clk;
  input [31:0]probe_in0;
  output [0:0]probe_out0;
  output [0:0]probe_out1;
  output [0:0]probe_out2;
  output [31:0]probe_out3;
  output [31:0]probe_out4;
  output [0:0]probe_out5;
  output [31:0]probe_out6;
endmodule
