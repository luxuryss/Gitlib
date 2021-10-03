// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
// Date        : Tue Sep 21 13:54:39 2021
// Host        : LAPTOP-62TT0BEG running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub D:/Project/1_prj/test/test/test.runs/vio_0_synth_1/vio_0_stub.v
// Design      : vio_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7k325tffg900-2
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* X_CORE_INFO = "vio,Vivado 2018.3" *)
module vio_0(clk, probe_in0, probe_out0, probe_out1, 
  probe_out2, probe_out3)
/* synthesis syn_black_box black_box_pad_pin="clk,probe_in0[31:0],probe_out0[31:0],probe_out1[31:0],probe_out2[31:0],probe_out3[31:0]" */;
  input clk;
  input [31:0]probe_in0;
  output [31:0]probe_out0;
  output [31:0]probe_out1;
  output [31:0]probe_out2;
  output [31:0]probe_out3;
endmodule
