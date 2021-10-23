//Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
//Date        : Tue Oct  5 23:00:31 2021
//Host        : LAPTOP-62TT0BEG running 64-bit major release  (build 9200)
//Command     : generate_target bd_ddr_wrapper.bd
//Design      : bd_ddr_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module bd_ddr_wrapper
   (DDR3_addr,
    DDR3_ba,
    DDR3_cas_n,
    DDR3_ck_n,
    DDR3_ck_p,
    DDR3_cke,
    DDR3_cs_n,
    DDR3_dm,
    DDR3_dq,
    DDR3_dqs_n,
    DDR3_dqs_p,
    DDR3_odt,
    DDR3_ras_n,
    DDR3_reset_n,
    DDR3_we_n,
    M_AXIS_MM2S_STS_tdata,
    M_AXIS_MM2S_STS_tkeep,
    M_AXIS_MM2S_STS_tlast,
    M_AXIS_MM2S_STS_tready,
    M_AXIS_MM2S_STS_tvalid,
    M_AXIS_MM2S_tdata,
    M_AXIS_MM2S_tkeep,
    M_AXIS_MM2S_tlast,
    M_AXIS_MM2S_tready,
    M_AXIS_MM2S_tvalid,
    M_AXIS_S2MM_STS_tdata,
    M_AXIS_S2MM_STS_tkeep,
    M_AXIS_S2MM_STS_tlast,
    M_AXIS_S2MM_STS_tready,
    M_AXIS_S2MM_STS_tvalid,
    S_AXIS_MM2S_CMD_tdata,
    S_AXIS_MM2S_CMD_tready,
    S_AXIS_MM2S_CMD_tvalid,
    S_AXIS_S2MM_CMD_tdata,
    S_AXIS_S2MM_CMD_tready,
    S_AXIS_S2MM_CMD_tvalid,
    S_AXIS_S2MM_tdata,
    S_AXIS_S2MM_tkeep,
    S_AXIS_S2MM_tlast,
    S_AXIS_S2MM_tready,
    S_AXIS_S2MM_tvalid,
    sys_clk,
    sys_rst,
    ui_clk);
  output [14:0]DDR3_addr;
  output [2:0]DDR3_ba;
  output DDR3_cas_n;
  output [0:0]DDR3_ck_n;
  output [0:0]DDR3_ck_p;
  output [0:0]DDR3_cke;
  output [0:0]DDR3_cs_n;
  output [7:0]DDR3_dm;
  inout [63:0]DDR3_dq;
  inout [7:0]DDR3_dqs_n;
  inout [7:0]DDR3_dqs_p;
  output [0:0]DDR3_odt;
  output DDR3_ras_n;
  output DDR3_reset_n;
  output DDR3_we_n;
  output [7:0]M_AXIS_MM2S_STS_tdata;
  output [0:0]M_AXIS_MM2S_STS_tkeep;
  output M_AXIS_MM2S_STS_tlast;
  input M_AXIS_MM2S_STS_tready;
  output M_AXIS_MM2S_STS_tvalid;
  output [63:0]M_AXIS_MM2S_tdata;
  output [7:0]M_AXIS_MM2S_tkeep;
  output M_AXIS_MM2S_tlast;
  input M_AXIS_MM2S_tready;
  output M_AXIS_MM2S_tvalid;
  output [31:0]M_AXIS_S2MM_STS_tdata;
  output [3:0]M_AXIS_S2MM_STS_tkeep;
  output M_AXIS_S2MM_STS_tlast;
  input M_AXIS_S2MM_STS_tready;
  output M_AXIS_S2MM_STS_tvalid;
  input [71:0]S_AXIS_MM2S_CMD_tdata;
  output S_AXIS_MM2S_CMD_tready;
  input S_AXIS_MM2S_CMD_tvalid;
  input [71:0]S_AXIS_S2MM_CMD_tdata;
  output S_AXIS_S2MM_CMD_tready;
  input S_AXIS_S2MM_CMD_tvalid;
  input [63:0]S_AXIS_S2MM_tdata;
  input [7:0]S_AXIS_S2MM_tkeep;
  input S_AXIS_S2MM_tlast;
  output S_AXIS_S2MM_tready;
  input S_AXIS_S2MM_tvalid;
  input sys_clk;
  input sys_rst;
  output ui_clk;

  wire [14:0]DDR3_addr;
  wire [2:0]DDR3_ba;
  wire DDR3_cas_n;
  wire [0:0]DDR3_ck_n;
  wire [0:0]DDR3_ck_p;
  wire [0:0]DDR3_cke;
  wire [0:0]DDR3_cs_n;
  wire [7:0]DDR3_dm;
  wire [63:0]DDR3_dq;
  wire [7:0]DDR3_dqs_n;
  wire [7:0]DDR3_dqs_p;
  wire [0:0]DDR3_odt;
  wire DDR3_ras_n;
  wire DDR3_reset_n;
  wire DDR3_we_n;
  wire [7:0]M_AXIS_MM2S_STS_tdata;
  wire [0:0]M_AXIS_MM2S_STS_tkeep;
  wire M_AXIS_MM2S_STS_tlast;
  wire M_AXIS_MM2S_STS_tready;
  wire M_AXIS_MM2S_STS_tvalid;
  wire [63:0]M_AXIS_MM2S_tdata;
  wire [7:0]M_AXIS_MM2S_tkeep;
  wire M_AXIS_MM2S_tlast;
  wire M_AXIS_MM2S_tready;
  wire M_AXIS_MM2S_tvalid;
  wire [31:0]M_AXIS_S2MM_STS_tdata;
  wire [3:0]M_AXIS_S2MM_STS_tkeep;
  wire M_AXIS_S2MM_STS_tlast;
  wire M_AXIS_S2MM_STS_tready;
  wire M_AXIS_S2MM_STS_tvalid;
  wire [71:0]S_AXIS_MM2S_CMD_tdata;
  wire S_AXIS_MM2S_CMD_tready;
  wire S_AXIS_MM2S_CMD_tvalid;
  wire [71:0]S_AXIS_S2MM_CMD_tdata;
  wire S_AXIS_S2MM_CMD_tready;
  wire S_AXIS_S2MM_CMD_tvalid;
  wire [63:0]S_AXIS_S2MM_tdata;
  wire [7:0]S_AXIS_S2MM_tkeep;
  wire S_AXIS_S2MM_tlast;
  wire S_AXIS_S2MM_tready;
  wire S_AXIS_S2MM_tvalid;
  wire sys_clk;
  wire sys_rst;
  wire ui_clk;

  bd_ddr bd_ddr_i
       (.DDR3_addr(DDR3_addr),
        .DDR3_ba(DDR3_ba),
        .DDR3_cas_n(DDR3_cas_n),
        .DDR3_ck_n(DDR3_ck_n),
        .DDR3_ck_p(DDR3_ck_p),
        .DDR3_cke(DDR3_cke),
        .DDR3_cs_n(DDR3_cs_n),
        .DDR3_dm(DDR3_dm),
        .DDR3_dq(DDR3_dq),
        .DDR3_dqs_n(DDR3_dqs_n),
        .DDR3_dqs_p(DDR3_dqs_p),
        .DDR3_odt(DDR3_odt),
        .DDR3_ras_n(DDR3_ras_n),
        .DDR3_reset_n(DDR3_reset_n),
        .DDR3_we_n(DDR3_we_n),
        .M_AXIS_MM2S_STS_tdata(M_AXIS_MM2S_STS_tdata),
        .M_AXIS_MM2S_STS_tkeep(M_AXIS_MM2S_STS_tkeep),
        .M_AXIS_MM2S_STS_tlast(M_AXIS_MM2S_STS_tlast),
        .M_AXIS_MM2S_STS_tready(M_AXIS_MM2S_STS_tready),
        .M_AXIS_MM2S_STS_tvalid(M_AXIS_MM2S_STS_tvalid),
        .M_AXIS_MM2S_tdata(M_AXIS_MM2S_tdata),
        .M_AXIS_MM2S_tkeep(M_AXIS_MM2S_tkeep),
        .M_AXIS_MM2S_tlast(M_AXIS_MM2S_tlast),
        .M_AXIS_MM2S_tready(M_AXIS_MM2S_tready),
        .M_AXIS_MM2S_tvalid(M_AXIS_MM2S_tvalid),
        .M_AXIS_S2MM_STS_tdata(M_AXIS_S2MM_STS_tdata),
        .M_AXIS_S2MM_STS_tkeep(M_AXIS_S2MM_STS_tkeep),
        .M_AXIS_S2MM_STS_tlast(M_AXIS_S2MM_STS_tlast),
        .M_AXIS_S2MM_STS_tready(M_AXIS_S2MM_STS_tready),
        .M_AXIS_S2MM_STS_tvalid(M_AXIS_S2MM_STS_tvalid),
        .S_AXIS_MM2S_CMD_tdata(S_AXIS_MM2S_CMD_tdata),
        .S_AXIS_MM2S_CMD_tready(S_AXIS_MM2S_CMD_tready),
        .S_AXIS_MM2S_CMD_tvalid(S_AXIS_MM2S_CMD_tvalid),
        .S_AXIS_S2MM_CMD_tdata(S_AXIS_S2MM_CMD_tdata),
        .S_AXIS_S2MM_CMD_tready(S_AXIS_S2MM_CMD_tready),
        .S_AXIS_S2MM_CMD_tvalid(S_AXIS_S2MM_CMD_tvalid),
        .S_AXIS_S2MM_tdata(S_AXIS_S2MM_tdata),
        .S_AXIS_S2MM_tkeep(S_AXIS_S2MM_tkeep),
        .S_AXIS_S2MM_tlast(S_AXIS_S2MM_tlast),
        .S_AXIS_S2MM_tready(S_AXIS_S2MM_tready),
        .S_AXIS_S2MM_tvalid(S_AXIS_S2MM_tvalid),
        .sys_clk(sys_clk),
        .sys_rst(sys_rst),
        .ui_clk(ui_clk));
endmodule
