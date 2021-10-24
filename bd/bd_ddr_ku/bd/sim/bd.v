//Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
//Date        : Sat Oct 23 20:25:35 2021
//Host        : LAPTOP-62TT0BEG running 64-bit major release  (build 9200)
//Command     : generate_target bd.bd
//Design      : bd
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CORE_GENERATION_INFO = "bd,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=bd,x_ipVersion=1.00.a,x_ipLanguage=VERILOG,numBlks=5,numReposBlks=5,numNonXlnxBlks=0,numHierBlks=0,maxHierDepth=0,numSysgenBlks=0,numHlsBlks=0,numHdlrefBlks=0,numPkgbdBlks=0,bdsource=USER,da_axi4_cnt=2,da_board_cnt=11,da_clkrst_cnt=8,synth_mode=OOC_per_IP}" *) (* HW_HANDOFF = "bd.hwdef" *) 
module bd
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
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 M_AXIS_MM2S_0 TDATA" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME M_AXIS_MM2S_0, CLK_DOMAIN bd_sys_clk, FREQ_HZ 200000000, HAS_TKEEP 1, HAS_TLAST 1, HAS_TREADY 1, HAS_TSTRB 0, INSERT_VIP 0, LAYERED_METADATA undef, PHASE 0.000, TDATA_NUM_BYTES 8, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0" *) output [63:0]M_AXIS_MM2S_0_tdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 M_AXIS_MM2S_0 TKEEP" *) output [7:0]M_AXIS_MM2S_0_tkeep;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 M_AXIS_MM2S_0 TLAST" *) output M_AXIS_MM2S_0_tlast;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 M_AXIS_MM2S_0 TREADY" *) input M_AXIS_MM2S_0_tready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 M_AXIS_MM2S_0 TVALID" *) output M_AXIS_MM2S_0_tvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 M_AXIS_MM2S_STS_0 TDATA" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME M_AXIS_MM2S_STS_0, CLK_DOMAIN bd_sys_clk, FREQ_HZ 200000000, HAS_TKEEP 1, HAS_TLAST 1, HAS_TREADY 1, HAS_TSTRB 0, INSERT_VIP 0, LAYERED_METADATA undef, PHASE 0.000, TDATA_NUM_BYTES 1, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0" *) output [7:0]M_AXIS_MM2S_STS_0_tdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 M_AXIS_MM2S_STS_0 TKEEP" *) output [0:0]M_AXIS_MM2S_STS_0_tkeep;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 M_AXIS_MM2S_STS_0 TLAST" *) output M_AXIS_MM2S_STS_0_tlast;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 M_AXIS_MM2S_STS_0 TREADY" *) input M_AXIS_MM2S_STS_0_tready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 M_AXIS_MM2S_STS_0 TVALID" *) output M_AXIS_MM2S_STS_0_tvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 M_AXIS_S2MM_STS_0 TDATA" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME M_AXIS_S2MM_STS_0, CLK_DOMAIN bd_sys_clk, FREQ_HZ 200000000, HAS_TKEEP 1, HAS_TLAST 1, HAS_TREADY 1, HAS_TSTRB 0, INSERT_VIP 0, LAYERED_METADATA undef, PHASE 0.000, TDATA_NUM_BYTES 4, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0" *) output [31:0]M_AXIS_S2MM_STS_0_tdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 M_AXIS_S2MM_STS_0 TKEEP" *) output [3:0]M_AXIS_S2MM_STS_0_tkeep;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 M_AXIS_S2MM_STS_0 TLAST" *) output M_AXIS_S2MM_STS_0_tlast;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 M_AXIS_S2MM_STS_0 TREADY" *) input M_AXIS_S2MM_STS_0_tready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 M_AXIS_S2MM_STS_0 TVALID" *) output M_AXIS_S2MM_STS_0_tvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS_MM2S_CMD_0 TDATA" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME S_AXIS_MM2S_CMD_0, CLK_DOMAIN bd_sys_clk, FREQ_HZ 200000000, HAS_TKEEP 0, HAS_TLAST 0, HAS_TREADY 1, HAS_TSTRB 0, INSERT_VIP 0, LAYERED_METADATA undef, PHASE 0.000, TDATA_NUM_BYTES 9, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0" *) input [71:0]S_AXIS_MM2S_CMD_0_tdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS_MM2S_CMD_0 TREADY" *) output S_AXIS_MM2S_CMD_0_tready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS_MM2S_CMD_0 TVALID" *) input S_AXIS_MM2S_CMD_0_tvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS_S2MM_0 TDATA" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME S_AXIS_S2MM_0, CLK_DOMAIN bd_sys_clk, FREQ_HZ 200000000, HAS_TKEEP 1, HAS_TLAST 1, HAS_TREADY 1, HAS_TSTRB 0, INSERT_VIP 0, LAYERED_METADATA undef, PHASE 0.000, TDATA_NUM_BYTES 8, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0" *) input [63:0]S_AXIS_S2MM_0_tdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS_S2MM_0 TKEEP" *) input [7:0]S_AXIS_S2MM_0_tkeep;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS_S2MM_0 TLAST" *) input S_AXIS_S2MM_0_tlast;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS_S2MM_0 TREADY" *) output S_AXIS_S2MM_0_tready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS_S2MM_0 TVALID" *) input S_AXIS_S2MM_0_tvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS_S2MM_CMD_0 TDATA" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME S_AXIS_S2MM_CMD_0, CLK_DOMAIN bd_sys_clk, FREQ_HZ 200000000, HAS_TKEEP 0, HAS_TLAST 0, HAS_TREADY 1, HAS_TSTRB 0, INSERT_VIP 0, LAYERED_METADATA undef, PHASE 0.000, TDATA_NUM_BYTES 9, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0" *) input [71:0]S_AXIS_S2MM_CMD_0_tdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS_S2MM_CMD_0 TREADY" *) output S_AXIS_S2MM_CMD_0_tready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS_S2MM_CMD_0 TVALID" *) input S_AXIS_S2MM_CMD_0_tvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:diff_clock:1.0 ddr4_clk " *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME ddr4_clk, CAN_DEBUG false, FREQ_HZ 100000000" *) input ddr4_clk_clk_n;
  (* X_INTERFACE_INFO = "xilinx.com:interface:diff_clock:1.0 ddr4_clk " *) input ddr4_clk_clk_p;
  output ddr4_init_done;
  (* X_INTERFACE_INFO = "xilinx.com:interface:ddr4:1.0 ddr4_rtl ACT_N" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME ddr4_rtl, AXI_ARBITRATION_SCHEME RD_PRI_REG, BURST_LENGTH 8, CAN_DEBUG false, CAS_LATENCY 16, CAS_WRITE_LATENCY 12, CS_ENABLED true, CUSTOM_PARTS no_file_loaded, DATA_MASK_ENABLED DM_NO_DBI, DATA_WIDTH 8, MEMORY_PART MT40A256M16GE-083E, MEMORY_TYPE Components, MEM_ADDR_MAP ROW_COLUMN_BANK, SLOT Single, TIMEPERIOD_PS 833" *) output ddr4_rtl_act_n;
  (* X_INTERFACE_INFO = "xilinx.com:interface:ddr4:1.0 ddr4_rtl ADR" *) output [16:0]ddr4_rtl_adr;
  (* X_INTERFACE_INFO = "xilinx.com:interface:ddr4:1.0 ddr4_rtl BA" *) output [1:0]ddr4_rtl_ba;
  (* X_INTERFACE_INFO = "xilinx.com:interface:ddr4:1.0 ddr4_rtl BG" *) output [0:0]ddr4_rtl_bg;
  (* X_INTERFACE_INFO = "xilinx.com:interface:ddr4:1.0 ddr4_rtl CK_C" *) output [0:0]ddr4_rtl_ck_c;
  (* X_INTERFACE_INFO = "xilinx.com:interface:ddr4:1.0 ddr4_rtl CK_T" *) output [0:0]ddr4_rtl_ck_t;
  (* X_INTERFACE_INFO = "xilinx.com:interface:ddr4:1.0 ddr4_rtl CKE" *) output [0:0]ddr4_rtl_cke;
  (* X_INTERFACE_INFO = "xilinx.com:interface:ddr4:1.0 ddr4_rtl CS_N" *) output [0:0]ddr4_rtl_cs_n;
  (* X_INTERFACE_INFO = "xilinx.com:interface:ddr4:1.0 ddr4_rtl DM_N" *) inout [0:0]ddr4_rtl_dm_n;
  (* X_INTERFACE_INFO = "xilinx.com:interface:ddr4:1.0 ddr4_rtl DQ" *) inout [7:0]ddr4_rtl_dq;
  (* X_INTERFACE_INFO = "xilinx.com:interface:ddr4:1.0 ddr4_rtl DQS_C" *) inout [0:0]ddr4_rtl_dqs_c;
  (* X_INTERFACE_INFO = "xilinx.com:interface:ddr4:1.0 ddr4_rtl DQS_T" *) inout [0:0]ddr4_rtl_dqs_t;
  (* X_INTERFACE_INFO = "xilinx.com:interface:ddr4:1.0 ddr4_rtl ODT" *) output [0:0]ddr4_rtl_odt;
  (* X_INTERFACE_INFO = "xilinx.com:interface:ddr4:1.0 ddr4_rtl RESET_N" *) output ddr4_rtl_reset_n;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK.SYS_CLK CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK.SYS_CLK, ASSOCIATED_BUSIF S_AXIS_MM2S_CMD_0:S_AXIS_S2MM_CMD_0:S_AXIS_S2MM_0:M_AXIS_MM2S_0:M_AXIS_MM2S_STS_0:M_AXIS_S2MM_STS_0, CLK_DOMAIN bd_sys_clk, FREQ_HZ 200000000, INSERT_VIP 0, PHASE 0.000" *) input sys_clk;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 RST.SYS_RST RST" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME RST.SYS_RST, INSERT_VIP 0, POLARITY ACTIVE_HIGH" *) input sys_rst;

  wire [71:0]S_AXIS_MM2S_CMD_0_1_TDATA;
  wire S_AXIS_MM2S_CMD_0_1_TREADY;
  wire S_AXIS_MM2S_CMD_0_1_TVALID;
  wire [63:0]S_AXIS_S2MM_0_1_TDATA;
  wire [7:0]S_AXIS_S2MM_0_1_TKEEP;
  wire S_AXIS_S2MM_0_1_TLAST;
  wire S_AXIS_S2MM_0_1_TREADY;
  wire S_AXIS_S2MM_0_1_TVALID;
  wire [71:0]S_AXIS_S2MM_CMD_0_1_TDATA;
  wire S_AXIS_S2MM_CMD_0_1_TREADY;
  wire S_AXIS_S2MM_CMD_0_1_TVALID;
  wire [7:0]axi_datamover_0_M_AXIS_MM2S_STS_TDATA;
  wire [0:0]axi_datamover_0_M_AXIS_MM2S_STS_TKEEP;
  wire axi_datamover_0_M_AXIS_MM2S_STS_TLAST;
  wire axi_datamover_0_M_AXIS_MM2S_STS_TREADY;
  wire axi_datamover_0_M_AXIS_MM2S_STS_TVALID;
  wire [63:0]axi_datamover_0_M_AXIS_MM2S_TDATA;
  wire [7:0]axi_datamover_0_M_AXIS_MM2S_TKEEP;
  wire axi_datamover_0_M_AXIS_MM2S_TLAST;
  wire axi_datamover_0_M_AXIS_MM2S_TREADY;
  wire axi_datamover_0_M_AXIS_MM2S_TVALID;
  wire [31:0]axi_datamover_0_M_AXIS_S2MM_STS_TDATA;
  wire [3:0]axi_datamover_0_M_AXIS_S2MM_STS_TKEEP;
  wire axi_datamover_0_M_AXIS_S2MM_STS_TLAST;
  wire axi_datamover_0_M_AXIS_S2MM_STS_TREADY;
  wire axi_datamover_0_M_AXIS_S2MM_STS_TVALID;
  wire [31:0]axi_datamover_0_M_AXI_MM2S_ARADDR;
  wire [1:0]axi_datamover_0_M_AXI_MM2S_ARBURST;
  wire [3:0]axi_datamover_0_M_AXI_MM2S_ARCACHE;
  wire [3:0]axi_datamover_0_M_AXI_MM2S_ARID;
  wire [7:0]axi_datamover_0_M_AXI_MM2S_ARLEN;
  wire [2:0]axi_datamover_0_M_AXI_MM2S_ARPROT;
  wire axi_datamover_0_M_AXI_MM2S_ARREADY;
  wire [2:0]axi_datamover_0_M_AXI_MM2S_ARSIZE;
  wire [3:0]axi_datamover_0_M_AXI_MM2S_ARUSER;
  wire axi_datamover_0_M_AXI_MM2S_ARVALID;
  wire [127:0]axi_datamover_0_M_AXI_MM2S_RDATA;
  wire axi_datamover_0_M_AXI_MM2S_RLAST;
  wire axi_datamover_0_M_AXI_MM2S_RREADY;
  wire [1:0]axi_datamover_0_M_AXI_MM2S_RRESP;
  wire axi_datamover_0_M_AXI_MM2S_RVALID;
  wire [31:0]axi_datamover_0_M_AXI_S2MM_AWADDR;
  wire [1:0]axi_datamover_0_M_AXI_S2MM_AWBURST;
  wire [3:0]axi_datamover_0_M_AXI_S2MM_AWCACHE;
  wire [3:0]axi_datamover_0_M_AXI_S2MM_AWID;
  wire [7:0]axi_datamover_0_M_AXI_S2MM_AWLEN;
  wire [2:0]axi_datamover_0_M_AXI_S2MM_AWPROT;
  wire axi_datamover_0_M_AXI_S2MM_AWREADY;
  wire [2:0]axi_datamover_0_M_AXI_S2MM_AWSIZE;
  wire [3:0]axi_datamover_0_M_AXI_S2MM_AWUSER;
  wire axi_datamover_0_M_AXI_S2MM_AWVALID;
  wire axi_datamover_0_M_AXI_S2MM_BREADY;
  wire [1:0]axi_datamover_0_M_AXI_S2MM_BRESP;
  wire axi_datamover_0_M_AXI_S2MM_BVALID;
  wire [127:0]axi_datamover_0_M_AXI_S2MM_WDATA;
  wire axi_datamover_0_M_AXI_S2MM_WLAST;
  wire axi_datamover_0_M_AXI_S2MM_WREADY;
  wire [15:0]axi_datamover_0_M_AXI_S2MM_WSTRB;
  wire axi_datamover_0_M_AXI_S2MM_WVALID;
  wire [27:0]axi_smc_M00_AXI_ARADDR;
  wire [1:0]axi_smc_M00_AXI_ARBURST;
  wire [3:0]axi_smc_M00_AXI_ARCACHE;
  wire [7:0]axi_smc_M00_AXI_ARLEN;
  wire [0:0]axi_smc_M00_AXI_ARLOCK;
  wire [2:0]axi_smc_M00_AXI_ARPROT;
  wire [3:0]axi_smc_M00_AXI_ARQOS;
  wire axi_smc_M00_AXI_ARREADY;
  wire [2:0]axi_smc_M00_AXI_ARSIZE;
  wire axi_smc_M00_AXI_ARVALID;
  wire [27:0]axi_smc_M00_AXI_AWADDR;
  wire [1:0]axi_smc_M00_AXI_AWBURST;
  wire [3:0]axi_smc_M00_AXI_AWCACHE;
  wire [7:0]axi_smc_M00_AXI_AWLEN;
  wire [0:0]axi_smc_M00_AXI_AWLOCK;
  wire [2:0]axi_smc_M00_AXI_AWPROT;
  wire [3:0]axi_smc_M00_AXI_AWQOS;
  wire axi_smc_M00_AXI_AWREADY;
  wire [2:0]axi_smc_M00_AXI_AWSIZE;
  wire axi_smc_M00_AXI_AWVALID;
  wire axi_smc_M00_AXI_BREADY;
  wire [1:0]axi_smc_M00_AXI_BRESP;
  wire axi_smc_M00_AXI_BVALID;
  wire [63:0]axi_smc_M00_AXI_RDATA;
  wire axi_smc_M00_AXI_RLAST;
  wire axi_smc_M00_AXI_RREADY;
  wire [1:0]axi_smc_M00_AXI_RRESP;
  wire axi_smc_M00_AXI_RVALID;
  wire [63:0]axi_smc_M00_AXI_WDATA;
  wire axi_smc_M00_AXI_WLAST;
  wire axi_smc_M00_AXI_WREADY;
  wire [7:0]axi_smc_M00_AXI_WSTRB;
  wire axi_smc_M00_AXI_WVALID;
  wire ddr4_0_C0_DDR4_ACT_N;
  wire [16:0]ddr4_0_C0_DDR4_ADR;
  wire [1:0]ddr4_0_C0_DDR4_BA;
  wire [0:0]ddr4_0_C0_DDR4_BG;
  wire [0:0]ddr4_0_C0_DDR4_CKE;
  wire [0:0]ddr4_0_C0_DDR4_CK_C;
  wire [0:0]ddr4_0_C0_DDR4_CK_T;
  wire [0:0]ddr4_0_C0_DDR4_CS_N;
  wire [0:0]ddr4_0_C0_DDR4_DM_N;
  wire [7:0]ddr4_0_C0_DDR4_DQ;
  wire [0:0]ddr4_0_C0_DDR4_DQS_C;
  wire [0:0]ddr4_0_C0_DDR4_DQS_T;
  wire [0:0]ddr4_0_C0_DDR4_ODT;
  wire ddr4_0_C0_DDR4_RESET_N;
  wire ddr4_0_c0_ddr4_ui_clk;
  wire ddr4_0_c0_ddr4_ui_clk_sync_rst;
  wire ddr4_0_c0_init_calib_complete;
  wire diff_clock_rtl_0_1_CLK_N;
  wire diff_clock_rtl_0_1_CLK_P;
  wire [0:0]rst_ddr4_0_300M_peripheral_aresetn;
  wire [0:0]rst_ddr4_300M_peripheral_aresetn;
  wire sys_clk_1;
  wire sys_rst_1;

  assign M_AXIS_MM2S_0_tdata[63:0] = axi_datamover_0_M_AXIS_MM2S_TDATA;
  assign M_AXIS_MM2S_0_tkeep[7:0] = axi_datamover_0_M_AXIS_MM2S_TKEEP;
  assign M_AXIS_MM2S_0_tlast = axi_datamover_0_M_AXIS_MM2S_TLAST;
  assign M_AXIS_MM2S_0_tvalid = axi_datamover_0_M_AXIS_MM2S_TVALID;
  assign M_AXIS_MM2S_STS_0_tdata[7:0] = axi_datamover_0_M_AXIS_MM2S_STS_TDATA;
  assign M_AXIS_MM2S_STS_0_tkeep[0] = axi_datamover_0_M_AXIS_MM2S_STS_TKEEP;
  assign M_AXIS_MM2S_STS_0_tlast = axi_datamover_0_M_AXIS_MM2S_STS_TLAST;
  assign M_AXIS_MM2S_STS_0_tvalid = axi_datamover_0_M_AXIS_MM2S_STS_TVALID;
  assign M_AXIS_S2MM_STS_0_tdata[31:0] = axi_datamover_0_M_AXIS_S2MM_STS_TDATA;
  assign M_AXIS_S2MM_STS_0_tkeep[3:0] = axi_datamover_0_M_AXIS_S2MM_STS_TKEEP;
  assign M_AXIS_S2MM_STS_0_tlast = axi_datamover_0_M_AXIS_S2MM_STS_TLAST;
  assign M_AXIS_S2MM_STS_0_tvalid = axi_datamover_0_M_AXIS_S2MM_STS_TVALID;
  assign S_AXIS_MM2S_CMD_0_1_TDATA = S_AXIS_MM2S_CMD_0_tdata[71:0];
  assign S_AXIS_MM2S_CMD_0_1_TVALID = S_AXIS_MM2S_CMD_0_tvalid;
  assign S_AXIS_MM2S_CMD_0_tready = S_AXIS_MM2S_CMD_0_1_TREADY;
  assign S_AXIS_S2MM_0_1_TDATA = S_AXIS_S2MM_0_tdata[63:0];
  assign S_AXIS_S2MM_0_1_TKEEP = S_AXIS_S2MM_0_tkeep[7:0];
  assign S_AXIS_S2MM_0_1_TLAST = S_AXIS_S2MM_0_tlast;
  assign S_AXIS_S2MM_0_1_TVALID = S_AXIS_S2MM_0_tvalid;
  assign S_AXIS_S2MM_0_tready = S_AXIS_S2MM_0_1_TREADY;
  assign S_AXIS_S2MM_CMD_0_1_TDATA = S_AXIS_S2MM_CMD_0_tdata[71:0];
  assign S_AXIS_S2MM_CMD_0_1_TVALID = S_AXIS_S2MM_CMD_0_tvalid;
  assign S_AXIS_S2MM_CMD_0_tready = S_AXIS_S2MM_CMD_0_1_TREADY;
  assign axi_datamover_0_M_AXIS_MM2S_STS_TREADY = M_AXIS_MM2S_STS_0_tready;
  assign axi_datamover_0_M_AXIS_MM2S_TREADY = M_AXIS_MM2S_0_tready;
  assign axi_datamover_0_M_AXIS_S2MM_STS_TREADY = M_AXIS_S2MM_STS_0_tready;
  assign ddr4_init_done = ddr4_0_c0_init_calib_complete;
  assign ddr4_rtl_act_n = ddr4_0_C0_DDR4_ACT_N;
  assign ddr4_rtl_adr[16:0] = ddr4_0_C0_DDR4_ADR;
  assign ddr4_rtl_ba[1:0] = ddr4_0_C0_DDR4_BA;
  assign ddr4_rtl_bg[0] = ddr4_0_C0_DDR4_BG;
  assign ddr4_rtl_ck_c[0] = ddr4_0_C0_DDR4_CK_C;
  assign ddr4_rtl_ck_t[0] = ddr4_0_C0_DDR4_CK_T;
  assign ddr4_rtl_cke[0] = ddr4_0_C0_DDR4_CKE;
  assign ddr4_rtl_cs_n[0] = ddr4_0_C0_DDR4_CS_N;
  assign ddr4_rtl_odt[0] = ddr4_0_C0_DDR4_ODT;
  assign ddr4_rtl_reset_n = ddr4_0_C0_DDR4_RESET_N;
  assign diff_clock_rtl_0_1_CLK_N = ddr4_clk_clk_n;
  assign diff_clock_rtl_0_1_CLK_P = ddr4_clk_clk_p;
  assign sys_clk_1 = sys_clk;
  assign sys_rst_1 = sys_rst;
  bd_axi_datamover_0_0 axi_datamover_0
       (.m_axi_mm2s_aclk(sys_clk_1),
        .m_axi_mm2s_araddr(axi_datamover_0_M_AXI_MM2S_ARADDR),
        .m_axi_mm2s_arburst(axi_datamover_0_M_AXI_MM2S_ARBURST),
        .m_axi_mm2s_arcache(axi_datamover_0_M_AXI_MM2S_ARCACHE),
        .m_axi_mm2s_aresetn(rst_ddr4_0_300M_peripheral_aresetn),
        .m_axi_mm2s_arid(axi_datamover_0_M_AXI_MM2S_ARID),
        .m_axi_mm2s_arlen(axi_datamover_0_M_AXI_MM2S_ARLEN),
        .m_axi_mm2s_arprot(axi_datamover_0_M_AXI_MM2S_ARPROT),
        .m_axi_mm2s_arready(axi_datamover_0_M_AXI_MM2S_ARREADY),
        .m_axi_mm2s_arsize(axi_datamover_0_M_AXI_MM2S_ARSIZE),
        .m_axi_mm2s_aruser(axi_datamover_0_M_AXI_MM2S_ARUSER),
        .m_axi_mm2s_arvalid(axi_datamover_0_M_AXI_MM2S_ARVALID),
        .m_axi_mm2s_rdata(axi_datamover_0_M_AXI_MM2S_RDATA),
        .m_axi_mm2s_rlast(axi_datamover_0_M_AXI_MM2S_RLAST),
        .m_axi_mm2s_rready(axi_datamover_0_M_AXI_MM2S_RREADY),
        .m_axi_mm2s_rresp(axi_datamover_0_M_AXI_MM2S_RRESP),
        .m_axi_mm2s_rvalid(axi_datamover_0_M_AXI_MM2S_RVALID),
        .m_axi_s2mm_aclk(sys_clk_1),
        .m_axi_s2mm_aresetn(rst_ddr4_0_300M_peripheral_aresetn),
        .m_axi_s2mm_awaddr(axi_datamover_0_M_AXI_S2MM_AWADDR),
        .m_axi_s2mm_awburst(axi_datamover_0_M_AXI_S2MM_AWBURST),
        .m_axi_s2mm_awcache(axi_datamover_0_M_AXI_S2MM_AWCACHE),
        .m_axi_s2mm_awid(axi_datamover_0_M_AXI_S2MM_AWID),
        .m_axi_s2mm_awlen(axi_datamover_0_M_AXI_S2MM_AWLEN),
        .m_axi_s2mm_awprot(axi_datamover_0_M_AXI_S2MM_AWPROT),
        .m_axi_s2mm_awready(axi_datamover_0_M_AXI_S2MM_AWREADY),
        .m_axi_s2mm_awsize(axi_datamover_0_M_AXI_S2MM_AWSIZE),
        .m_axi_s2mm_awuser(axi_datamover_0_M_AXI_S2MM_AWUSER),
        .m_axi_s2mm_awvalid(axi_datamover_0_M_AXI_S2MM_AWVALID),
        .m_axi_s2mm_bready(axi_datamover_0_M_AXI_S2MM_BREADY),
        .m_axi_s2mm_bresp(axi_datamover_0_M_AXI_S2MM_BRESP),
        .m_axi_s2mm_bvalid(axi_datamover_0_M_AXI_S2MM_BVALID),
        .m_axi_s2mm_wdata(axi_datamover_0_M_AXI_S2MM_WDATA),
        .m_axi_s2mm_wlast(axi_datamover_0_M_AXI_S2MM_WLAST),
        .m_axi_s2mm_wready(axi_datamover_0_M_AXI_S2MM_WREADY),
        .m_axi_s2mm_wstrb(axi_datamover_0_M_AXI_S2MM_WSTRB),
        .m_axi_s2mm_wvalid(axi_datamover_0_M_AXI_S2MM_WVALID),
        .m_axis_mm2s_cmdsts_aclk(sys_clk_1),
        .m_axis_mm2s_cmdsts_aresetn(rst_ddr4_0_300M_peripheral_aresetn),
        .m_axis_mm2s_sts_tdata(axi_datamover_0_M_AXIS_MM2S_STS_TDATA),
        .m_axis_mm2s_sts_tkeep(axi_datamover_0_M_AXIS_MM2S_STS_TKEEP),
        .m_axis_mm2s_sts_tlast(axi_datamover_0_M_AXIS_MM2S_STS_TLAST),
        .m_axis_mm2s_sts_tready(axi_datamover_0_M_AXIS_MM2S_STS_TREADY),
        .m_axis_mm2s_sts_tvalid(axi_datamover_0_M_AXIS_MM2S_STS_TVALID),
        .m_axis_mm2s_tdata(axi_datamover_0_M_AXIS_MM2S_TDATA),
        .m_axis_mm2s_tkeep(axi_datamover_0_M_AXIS_MM2S_TKEEP),
        .m_axis_mm2s_tlast(axi_datamover_0_M_AXIS_MM2S_TLAST),
        .m_axis_mm2s_tready(axi_datamover_0_M_AXIS_MM2S_TREADY),
        .m_axis_mm2s_tvalid(axi_datamover_0_M_AXIS_MM2S_TVALID),
        .m_axis_s2mm_cmdsts_aresetn(rst_ddr4_0_300M_peripheral_aresetn),
        .m_axis_s2mm_cmdsts_awclk(sys_clk_1),
        .m_axis_s2mm_sts_tdata(axi_datamover_0_M_AXIS_S2MM_STS_TDATA),
        .m_axis_s2mm_sts_tkeep(axi_datamover_0_M_AXIS_S2MM_STS_TKEEP),
        .m_axis_s2mm_sts_tlast(axi_datamover_0_M_AXIS_S2MM_STS_TLAST),
        .m_axis_s2mm_sts_tready(axi_datamover_0_M_AXIS_S2MM_STS_TREADY),
        .m_axis_s2mm_sts_tvalid(axi_datamover_0_M_AXIS_S2MM_STS_TVALID),
        .s_axis_mm2s_cmd_tdata(S_AXIS_MM2S_CMD_0_1_TDATA),
        .s_axis_mm2s_cmd_tready(S_AXIS_MM2S_CMD_0_1_TREADY),
        .s_axis_mm2s_cmd_tvalid(S_AXIS_MM2S_CMD_0_1_TVALID),
        .s_axis_s2mm_cmd_tdata(S_AXIS_S2MM_CMD_0_1_TDATA),
        .s_axis_s2mm_cmd_tready(S_AXIS_S2MM_CMD_0_1_TREADY),
        .s_axis_s2mm_cmd_tvalid(S_AXIS_S2MM_CMD_0_1_TVALID),
        .s_axis_s2mm_tdata(S_AXIS_S2MM_0_1_TDATA),
        .s_axis_s2mm_tkeep(S_AXIS_S2MM_0_1_TKEEP),
        .s_axis_s2mm_tlast(S_AXIS_S2MM_0_1_TLAST),
        .s_axis_s2mm_tready(S_AXIS_S2MM_0_1_TREADY),
        .s_axis_s2mm_tvalid(S_AXIS_S2MM_0_1_TVALID));
  bd_axi_smc_0 axi_smc
       (.M00_AXI_araddr(axi_smc_M00_AXI_ARADDR),
        .M00_AXI_arburst(axi_smc_M00_AXI_ARBURST),
        .M00_AXI_arcache(axi_smc_M00_AXI_ARCACHE),
        .M00_AXI_arlen(axi_smc_M00_AXI_ARLEN),
        .M00_AXI_arlock(axi_smc_M00_AXI_ARLOCK),
        .M00_AXI_arprot(axi_smc_M00_AXI_ARPROT),
        .M00_AXI_arqos(axi_smc_M00_AXI_ARQOS),
        .M00_AXI_arready(axi_smc_M00_AXI_ARREADY),
        .M00_AXI_arsize(axi_smc_M00_AXI_ARSIZE),
        .M00_AXI_arvalid(axi_smc_M00_AXI_ARVALID),
        .M00_AXI_awaddr(axi_smc_M00_AXI_AWADDR),
        .M00_AXI_awburst(axi_smc_M00_AXI_AWBURST),
        .M00_AXI_awcache(axi_smc_M00_AXI_AWCACHE),
        .M00_AXI_awlen(axi_smc_M00_AXI_AWLEN),
        .M00_AXI_awlock(axi_smc_M00_AXI_AWLOCK),
        .M00_AXI_awprot(axi_smc_M00_AXI_AWPROT),
        .M00_AXI_awqos(axi_smc_M00_AXI_AWQOS),
        .M00_AXI_awready(axi_smc_M00_AXI_AWREADY),
        .M00_AXI_awsize(axi_smc_M00_AXI_AWSIZE),
        .M00_AXI_awvalid(axi_smc_M00_AXI_AWVALID),
        .M00_AXI_bready(axi_smc_M00_AXI_BREADY),
        .M00_AXI_bresp(axi_smc_M00_AXI_BRESP),
        .M00_AXI_bvalid(axi_smc_M00_AXI_BVALID),
        .M00_AXI_rdata(axi_smc_M00_AXI_RDATA),
        .M00_AXI_rlast(axi_smc_M00_AXI_RLAST),
        .M00_AXI_rready(axi_smc_M00_AXI_RREADY),
        .M00_AXI_rresp(axi_smc_M00_AXI_RRESP),
        .M00_AXI_rvalid(axi_smc_M00_AXI_RVALID),
        .M00_AXI_wdata(axi_smc_M00_AXI_WDATA),
        .M00_AXI_wlast(axi_smc_M00_AXI_WLAST),
        .M00_AXI_wready(axi_smc_M00_AXI_WREADY),
        .M00_AXI_wstrb(axi_smc_M00_AXI_WSTRB),
        .M00_AXI_wvalid(axi_smc_M00_AXI_WVALID),
        .S00_AXI_araddr(axi_datamover_0_M_AXI_MM2S_ARADDR),
        .S00_AXI_arburst(axi_datamover_0_M_AXI_MM2S_ARBURST),
        .S00_AXI_arcache(axi_datamover_0_M_AXI_MM2S_ARCACHE),
        .S00_AXI_arid(axi_datamover_0_M_AXI_MM2S_ARID),
        .S00_AXI_arlen(axi_datamover_0_M_AXI_MM2S_ARLEN),
        .S00_AXI_arlock(1'b0),
        .S00_AXI_arprot(axi_datamover_0_M_AXI_MM2S_ARPROT),
        .S00_AXI_arqos({1'b0,1'b0,1'b0,1'b0}),
        .S00_AXI_arready(axi_datamover_0_M_AXI_MM2S_ARREADY),
        .S00_AXI_arsize(axi_datamover_0_M_AXI_MM2S_ARSIZE),
        .S00_AXI_aruser(axi_datamover_0_M_AXI_MM2S_ARUSER),
        .S00_AXI_arvalid(axi_datamover_0_M_AXI_MM2S_ARVALID),
        .S00_AXI_rdata(axi_datamover_0_M_AXI_MM2S_RDATA),
        .S00_AXI_rlast(axi_datamover_0_M_AXI_MM2S_RLAST),
        .S00_AXI_rready(axi_datamover_0_M_AXI_MM2S_RREADY),
        .S00_AXI_rresp(axi_datamover_0_M_AXI_MM2S_RRESP),
        .S00_AXI_rvalid(axi_datamover_0_M_AXI_MM2S_RVALID),
        .S01_AXI_awaddr(axi_datamover_0_M_AXI_S2MM_AWADDR),
        .S01_AXI_awburst(axi_datamover_0_M_AXI_S2MM_AWBURST),
        .S01_AXI_awcache(axi_datamover_0_M_AXI_S2MM_AWCACHE),
        .S01_AXI_awid(axi_datamover_0_M_AXI_S2MM_AWID),
        .S01_AXI_awlen(axi_datamover_0_M_AXI_S2MM_AWLEN),
        .S01_AXI_awlock(1'b0),
        .S01_AXI_awprot(axi_datamover_0_M_AXI_S2MM_AWPROT),
        .S01_AXI_awqos({1'b0,1'b0,1'b0,1'b0}),
        .S01_AXI_awready(axi_datamover_0_M_AXI_S2MM_AWREADY),
        .S01_AXI_awsize(axi_datamover_0_M_AXI_S2MM_AWSIZE),
        .S01_AXI_awuser(axi_datamover_0_M_AXI_S2MM_AWUSER),
        .S01_AXI_awvalid(axi_datamover_0_M_AXI_S2MM_AWVALID),
        .S01_AXI_bready(axi_datamover_0_M_AXI_S2MM_BREADY),
        .S01_AXI_bresp(axi_datamover_0_M_AXI_S2MM_BRESP),
        .S01_AXI_bvalid(axi_datamover_0_M_AXI_S2MM_BVALID),
        .S01_AXI_wdata(axi_datamover_0_M_AXI_S2MM_WDATA),
        .S01_AXI_wlast(axi_datamover_0_M_AXI_S2MM_WLAST),
        .S01_AXI_wready(axi_datamover_0_M_AXI_S2MM_WREADY),
        .S01_AXI_wstrb(axi_datamover_0_M_AXI_S2MM_WSTRB),
        .S01_AXI_wvalid(axi_datamover_0_M_AXI_S2MM_WVALID),
        .aclk(sys_clk_1),
        .aclk1(ddr4_0_c0_ddr4_ui_clk),
        .aresetn(rst_ddr4_0_300M_peripheral_aresetn));
  bd_ddr4_0_0 ddr4_0
       (.c0_ddr4_act_n(ddr4_0_C0_DDR4_ACT_N),
        .c0_ddr4_adr(ddr4_0_C0_DDR4_ADR),
        .c0_ddr4_aresetn(rst_ddr4_300M_peripheral_aresetn),
        .c0_ddr4_ba(ddr4_0_C0_DDR4_BA),
        .c0_ddr4_bg(ddr4_0_C0_DDR4_BG),
        .c0_ddr4_ck_c(ddr4_0_C0_DDR4_CK_C),
        .c0_ddr4_ck_t(ddr4_0_C0_DDR4_CK_T),
        .c0_ddr4_cke(ddr4_0_C0_DDR4_CKE),
        .c0_ddr4_cs_n(ddr4_0_C0_DDR4_CS_N),
        .c0_ddr4_dm_dbi_n(ddr4_rtl_dm_n[0]),
        .c0_ddr4_dq(ddr4_rtl_dq[7:0]),
        .c0_ddr4_dqs_c(ddr4_rtl_dqs_c[0]),
        .c0_ddr4_dqs_t(ddr4_rtl_dqs_t[0]),
        .c0_ddr4_odt(ddr4_0_C0_DDR4_ODT),
        .c0_ddr4_reset_n(ddr4_0_C0_DDR4_RESET_N),
        .c0_ddr4_s_axi_araddr(axi_smc_M00_AXI_ARADDR),
        .c0_ddr4_s_axi_arburst(axi_smc_M00_AXI_ARBURST),
        .c0_ddr4_s_axi_arcache(axi_smc_M00_AXI_ARCACHE),
        .c0_ddr4_s_axi_arid(1'b0),
        .c0_ddr4_s_axi_arlen(axi_smc_M00_AXI_ARLEN),
        .c0_ddr4_s_axi_arlock(axi_smc_M00_AXI_ARLOCK),
        .c0_ddr4_s_axi_arprot(axi_smc_M00_AXI_ARPROT),
        .c0_ddr4_s_axi_arqos(axi_smc_M00_AXI_ARQOS),
        .c0_ddr4_s_axi_arready(axi_smc_M00_AXI_ARREADY),
        .c0_ddr4_s_axi_arsize(axi_smc_M00_AXI_ARSIZE),
        .c0_ddr4_s_axi_arvalid(axi_smc_M00_AXI_ARVALID),
        .c0_ddr4_s_axi_awaddr(axi_smc_M00_AXI_AWADDR),
        .c0_ddr4_s_axi_awburst(axi_smc_M00_AXI_AWBURST),
        .c0_ddr4_s_axi_awcache(axi_smc_M00_AXI_AWCACHE),
        .c0_ddr4_s_axi_awid(1'b0),
        .c0_ddr4_s_axi_awlen(axi_smc_M00_AXI_AWLEN),
        .c0_ddr4_s_axi_awlock(axi_smc_M00_AXI_AWLOCK),
        .c0_ddr4_s_axi_awprot(axi_smc_M00_AXI_AWPROT),
        .c0_ddr4_s_axi_awqos(axi_smc_M00_AXI_AWQOS),
        .c0_ddr4_s_axi_awready(axi_smc_M00_AXI_AWREADY),
        .c0_ddr4_s_axi_awsize(axi_smc_M00_AXI_AWSIZE),
        .c0_ddr4_s_axi_awvalid(axi_smc_M00_AXI_AWVALID),
        .c0_ddr4_s_axi_bready(axi_smc_M00_AXI_BREADY),
        .c0_ddr4_s_axi_bresp(axi_smc_M00_AXI_BRESP),
        .c0_ddr4_s_axi_bvalid(axi_smc_M00_AXI_BVALID),
        .c0_ddr4_s_axi_rdata(axi_smc_M00_AXI_RDATA),
        .c0_ddr4_s_axi_rlast(axi_smc_M00_AXI_RLAST),
        .c0_ddr4_s_axi_rready(axi_smc_M00_AXI_RREADY),
        .c0_ddr4_s_axi_rresp(axi_smc_M00_AXI_RRESP),
        .c0_ddr4_s_axi_rvalid(axi_smc_M00_AXI_RVALID),
        .c0_ddr4_s_axi_wdata(axi_smc_M00_AXI_WDATA),
        .c0_ddr4_s_axi_wlast(axi_smc_M00_AXI_WLAST),
        .c0_ddr4_s_axi_wready(axi_smc_M00_AXI_WREADY),
        .c0_ddr4_s_axi_wstrb(axi_smc_M00_AXI_WSTRB),
        .c0_ddr4_s_axi_wvalid(axi_smc_M00_AXI_WVALID),
        .c0_ddr4_ui_clk(ddr4_0_c0_ddr4_ui_clk),
        .c0_ddr4_ui_clk_sync_rst(ddr4_0_c0_ddr4_ui_clk_sync_rst),
        .c0_init_calib_complete(ddr4_0_c0_init_calib_complete),
        .c0_sys_clk_n(diff_clock_rtl_0_1_CLK_N),
        .c0_sys_clk_p(diff_clock_rtl_0_1_CLK_P),
        .sys_rst(sys_rst_1));
  bd_proc_sys_reset_0_0 rst_ddr4_300M
       (.aux_reset_in(1'b1),
        .dcm_locked(1'b1),
        .ext_reset_in(ddr4_0_c0_ddr4_ui_clk_sync_rst),
        .mb_debug_sys_rst(1'b0),
        .peripheral_aresetn(rst_ddr4_300M_peripheral_aresetn),
        .slowest_sync_clk(ddr4_0_c0_ddr4_ui_clk));
  bd_rst_ddr4_0_300M_0 rst_sys_200M
       (.aux_reset_in(1'b1),
        .dcm_locked(1'b1),
        .ext_reset_in(sys_rst_1),
        .mb_debug_sys_rst(1'b0),
        .peripheral_aresetn(rst_ddr4_0_300M_peripheral_aresetn),
        .slowest_sync_clk(sys_clk_1));
endmodule
