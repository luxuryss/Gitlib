//Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
//Date        : Sat Oct 23 20:25:36 2021
//Host        : LAPTOP-62TT0BEG running 64-bit major release  (build 9200)
//Command     : generate_target bd_wrapper.bd
//Design      : bd_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module bd_wrapper
   (M_AXIS_MM2S_0_tdata,
    M_AXIS_MM2S_0_tkeep,
    M_AXIS_MM2S_0_tlast,
    M_AXIS_MM2S_0_tready,
    M_AXIS_MM2S_0_tvalid,
    M_AXIS_MM2S_STS_0_tdata,
    M_AXIS_MM2S_STS_0_tkeep,
    M_AXIS_MM2S_STS_0_tlast,
    M_AXIS_MM2S_STS_0_tready,
    M_AXIS_MM2S_STS_0_tvalid,
    M_AXIS_S2MM_STS_0_tdata,
    M_AXIS_S2MM_STS_0_tkeep,
    M_AXIS_S2MM_STS_0_tlast,
    M_AXIS_S2MM_STS_0_tready,
    M_AXIS_S2MM_STS_0_tvalid,
    S_AXIS_MM2S_CMD_0_tdata,
    S_AXIS_MM2S_CMD_0_tready,
    S_AXIS_MM2S_CMD_0_tvalid,
    S_AXIS_S2MM_0_tdata,
    S_AXIS_S2MM_0_tkeep,
    S_AXIS_S2MM_0_tlast,
    S_AXIS_S2MM_0_tready,
    S_AXIS_S2MM_0_tvalid,
    S_AXIS_S2MM_CMD_0_tdata,
    S_AXIS_S2MM_CMD_0_tready,
    S_AXIS_S2MM_CMD_0_tvalid,
    ddr4_clk_clk_n,
    ddr4_clk_clk_p,
    ddr4_init_done,
    ddr4_rtl_act_n,
    ddr4_rtl_adr,
    ddr4_rtl_ba,
    ddr4_rtl_bg,
    ddr4_rtl_ck_c,
    ddr4_rtl_ck_t,
    ddr4_rtl_cke,
    ddr4_rtl_cs_n,
    ddr4_rtl_dm_n,
    ddr4_rtl_dq,
    ddr4_rtl_dqs_c,
    ddr4_rtl_dqs_t,
    ddr4_rtl_odt,
    ddr4_rtl_reset_n,
    sys_clk,
    sys_rst);
  output [63:0]M_AXIS_MM2S_0_tdata;
  output [7:0]M_AXIS_MM2S_0_tkeep;
  output M_AXIS_MM2S_0_tlast;
  input M_AXIS_MM2S_0_tready;
  output M_AXIS_MM2S_0_tvalid;
  output [7:0]M_AXIS_MM2S_STS_0_tdata;
  output [0:0]M_AXIS_MM2S_STS_0_tkeep;
  output M_AXIS_MM2S_STS_0_tlast;
  input M_AXIS_MM2S_STS_0_tready;
  output M_AXIS_MM2S_STS_0_tvalid;
  output [31:0]M_AXIS_S2MM_STS_0_tdata;
  output [3:0]M_AXIS_S2MM_STS_0_tkeep;
  output M_AXIS_S2MM_STS_0_tlast;
  input M_AXIS_S2MM_STS_0_tready;
  output M_AXIS_S2MM_STS_0_tvalid;
  input [71:0]S_AXIS_MM2S_CMD_0_tdata;
  output S_AXIS_MM2S_CMD_0_tready;
  input S_AXIS_MM2S_CMD_0_tvalid;
  input [63:0]S_AXIS_S2MM_0_tdata;
  input [7:0]S_AXIS_S2MM_0_tkeep;
  input S_AXIS_S2MM_0_tlast;
  output S_AXIS_S2MM_0_tready;
  input S_AXIS_S2MM_0_tvalid;
  input [71:0]S_AXIS_S2MM_CMD_0_tdata;
  output S_AXIS_S2MM_CMD_0_tready;
  input S_AXIS_S2MM_CMD_0_tvalid;
  input ddr4_clk_clk_n;
  input ddr4_clk_clk_p;
  output ddr4_init_done;
  output ddr4_rtl_act_n;
  output [16:0]ddr4_rtl_adr;
  output [1:0]ddr4_rtl_ba;
  output [0:0]ddr4_rtl_bg;
  output [0:0]ddr4_rtl_ck_c;
  output [0:0]ddr4_rtl_ck_t;
  output [0:0]ddr4_rtl_cke;
  output [0:0]ddr4_rtl_cs_n;
  inout [0:0]ddr4_rtl_dm_n;
  inout [7:0]ddr4_rtl_dq;
  inout [0:0]ddr4_rtl_dqs_c;
  inout [0:0]ddr4_rtl_dqs_t;
  output [0:0]ddr4_rtl_odt;
  output ddr4_rtl_reset_n;
  input sys_clk;
  input sys_rst;

  wire [63:0]M_AXIS_MM2S_0_tdata;
  wire [7:0]M_AXIS_MM2S_0_tkeep;
  wire M_AXIS_MM2S_0_tlast;
  wire M_AXIS_MM2S_0_tready;
  wire M_AXIS_MM2S_0_tvalid;
  wire [7:0]M_AXIS_MM2S_STS_0_tdata;
  wire [0:0]M_AXIS_MM2S_STS_0_tkeep;
  wire M_AXIS_MM2S_STS_0_tlast;
  wire M_AXIS_MM2S_STS_0_tready;
  wire M_AXIS_MM2S_STS_0_tvalid;
  wire [31:0]M_AXIS_S2MM_STS_0_tdata;
  wire [3:0]M_AXIS_S2MM_STS_0_tkeep;
  wire M_AXIS_S2MM_STS_0_tlast;
  wire M_AXIS_S2MM_STS_0_tready;
  wire M_AXIS_S2MM_STS_0_tvalid;
  wire [71:0]S_AXIS_MM2S_CMD_0_tdata;
  wire S_AXIS_MM2S_CMD_0_tready;
  wire S_AXIS_MM2S_CMD_0_tvalid;
  wire [63:0]S_AXIS_S2MM_0_tdata;
  wire [7:0]S_AXIS_S2MM_0_tkeep;
  wire S_AXIS_S2MM_0_tlast;
  wire S_AXIS_S2MM_0_tready;
  wire S_AXIS_S2MM_0_tvalid;
  wire [71:0]S_AXIS_S2MM_CMD_0_tdata;
  wire S_AXIS_S2MM_CMD_0_tready;
  wire S_AXIS_S2MM_CMD_0_tvalid;
  wire ddr4_clk_clk_n;
  wire ddr4_clk_clk_p;
  wire ddr4_init_done;
  wire ddr4_rtl_act_n;
  wire [16:0]ddr4_rtl_adr;
  wire [1:0]ddr4_rtl_ba;
  wire [0:0]ddr4_rtl_bg;
  wire [0:0]ddr4_rtl_ck_c;
  wire [0:0]ddr4_rtl_ck_t;
  wire [0:0]ddr4_rtl_cke;
  wire [0:0]ddr4_rtl_cs_n;
  wire [0:0]ddr4_rtl_dm_n;
  wire [7:0]ddr4_rtl_dq;
  wire [0:0]ddr4_rtl_dqs_c;
  wire [0:0]ddr4_rtl_dqs_t;
  wire [0:0]ddr4_rtl_odt;
  wire ddr4_rtl_reset_n;
  wire sys_clk;
  wire sys_rst;

  bd bd_i
       (.M_AXIS_MM2S_0_tdata(M_AXIS_MM2S_0_tdata),
        .M_AXIS_MM2S_0_tkeep(M_AXIS_MM2S_0_tkeep),
        .M_AXIS_MM2S_0_tlast(M_AXIS_MM2S_0_tlast),
        .M_AXIS_MM2S_0_tready(M_AXIS_MM2S_0_tready),
        .M_AXIS_MM2S_0_tvalid(M_AXIS_MM2S_0_tvalid),
        .M_AXIS_MM2S_STS_0_tdata(M_AXIS_MM2S_STS_0_tdata),
        .M_AXIS_MM2S_STS_0_tkeep(M_AXIS_MM2S_STS_0_tkeep),
        .M_AXIS_MM2S_STS_0_tlast(M_AXIS_MM2S_STS_0_tlast),
        .M_AXIS_MM2S_STS_0_tready(M_AXIS_MM2S_STS_0_tready),
        .M_AXIS_MM2S_STS_0_tvalid(M_AXIS_MM2S_STS_0_tvalid),
        .M_AXIS_S2MM_STS_0_tdata(M_AXIS_S2MM_STS_0_tdata),
        .M_AXIS_S2MM_STS_0_tkeep(M_AXIS_S2MM_STS_0_tkeep),
        .M_AXIS_S2MM_STS_0_tlast(M_AXIS_S2MM_STS_0_tlast),
        .M_AXIS_S2MM_STS_0_tready(M_AXIS_S2MM_STS_0_tready),
        .M_AXIS_S2MM_STS_0_tvalid(M_AXIS_S2MM_STS_0_tvalid),
        .S_AXIS_MM2S_CMD_0_tdata(S_AXIS_MM2S_CMD_0_tdata),
        .S_AXIS_MM2S_CMD_0_tready(S_AXIS_MM2S_CMD_0_tready),
        .S_AXIS_MM2S_CMD_0_tvalid(S_AXIS_MM2S_CMD_0_tvalid),
        .S_AXIS_S2MM_0_tdata(S_AXIS_S2MM_0_tdata),
        .S_AXIS_S2MM_0_tkeep(S_AXIS_S2MM_0_tkeep),
        .S_AXIS_S2MM_0_tlast(S_AXIS_S2MM_0_tlast),
        .S_AXIS_S2MM_0_tready(S_AXIS_S2MM_0_tready),
        .S_AXIS_S2MM_0_tvalid(S_AXIS_S2MM_0_tvalid),
        .S_AXIS_S2MM_CMD_0_tdata(S_AXIS_S2MM_CMD_0_tdata),
        .S_AXIS_S2MM_CMD_0_tready(S_AXIS_S2MM_CMD_0_tready),
        .S_AXIS_S2MM_CMD_0_tvalid(S_AXIS_S2MM_CMD_0_tvalid),
        .ddr4_clk_clk_n(ddr4_clk_clk_n),
        .ddr4_clk_clk_p(ddr4_clk_clk_p),
        .ddr4_init_done(ddr4_init_done),
        .ddr4_rtl_act_n(ddr4_rtl_act_n),
        .ddr4_rtl_adr(ddr4_rtl_adr),
        .ddr4_rtl_ba(ddr4_rtl_ba),
        .ddr4_rtl_bg(ddr4_rtl_bg),
        .ddr4_rtl_ck_c(ddr4_rtl_ck_c),
        .ddr4_rtl_ck_t(ddr4_rtl_ck_t),
        .ddr4_rtl_cke(ddr4_rtl_cke),
        .ddr4_rtl_cs_n(ddr4_rtl_cs_n),
        .ddr4_rtl_dm_n(ddr4_rtl_dm_n),
        .ddr4_rtl_dq(ddr4_rtl_dq),
        .ddr4_rtl_dqs_c(ddr4_rtl_dqs_c),
        .ddr4_rtl_dqs_t(ddr4_rtl_dqs_t),
        .ddr4_rtl_odt(ddr4_rtl_odt),
        .ddr4_rtl_reset_n(ddr4_rtl_reset_n),
        .sys_clk(sys_clk),
        .sys_rst(sys_rst));
endmodule
