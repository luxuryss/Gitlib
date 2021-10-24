//Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
//Date        : Tue Oct  5 23:00:31 2021
//Host        : LAPTOP-62TT0BEG running 64-bit major release  (build 9200)
//Command     : generate_target bd_ddr.bd
//Design      : bd_ddr
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CORE_GENERATION_INFO = "bd_ddr,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=bd_ddr,x_ipVersion=1.00.a,x_ipLanguage=VERILOG,numBlks=4,numReposBlks=4,numNonXlnxBlks=0,numHierBlks=0,maxHierDepth=0,numSysgenBlks=0,numHlsBlks=0,numHdlrefBlks=0,numPkgbdBlks=0,bdsource=USER,da_axi4_cnt=2,da_board_cnt=1,da_clkrst_cnt=2,synth_mode=OOC_per_IP}" *) (* HW_HANDOFF = "bd_ddr.hwdef" *) 
module bd_ddr
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
  (* X_INTERFACE_INFO = "xilinx.com:interface:ddrx:1.0 DDR3 ADDR" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME DDR3, AXI_ARBITRATION_SCHEME TDM, BURST_LENGTH 8, CAN_DEBUG false, CAS_LATENCY 11, CAS_WRITE_LATENCY 11, CS_ENABLED true, DATA_MASK_ENABLED true, DATA_WIDTH 8, MEMORY_TYPE COMPONENTS, MEM_ADDR_MAP ROW_COLUMN_BANK, SLOT Single, TIMEPERIOD_PS 1250" *) output [14:0]DDR3_addr;
  (* X_INTERFACE_INFO = "xilinx.com:interface:ddrx:1.0 DDR3 BA" *) output [2:0]DDR3_ba;
  (* X_INTERFACE_INFO = "xilinx.com:interface:ddrx:1.0 DDR3 CAS_N" *) output DDR3_cas_n;
  (* X_INTERFACE_INFO = "xilinx.com:interface:ddrx:1.0 DDR3 CK_N" *) output [0:0]DDR3_ck_n;
  (* X_INTERFACE_INFO = "xilinx.com:interface:ddrx:1.0 DDR3 CK_P" *) output [0:0]DDR3_ck_p;
  (* X_INTERFACE_INFO = "xilinx.com:interface:ddrx:1.0 DDR3 CKE" *) output [0:0]DDR3_cke;
  (* X_INTERFACE_INFO = "xilinx.com:interface:ddrx:1.0 DDR3 CS_N" *) output [0:0]DDR3_cs_n;
  (* X_INTERFACE_INFO = "xilinx.com:interface:ddrx:1.0 DDR3 DM" *) output [7:0]DDR3_dm;
  (* X_INTERFACE_INFO = "xilinx.com:interface:ddrx:1.0 DDR3 DQ" *) inout [63:0]DDR3_dq;
  (* X_INTERFACE_INFO = "xilinx.com:interface:ddrx:1.0 DDR3 DQS_N" *) inout [7:0]DDR3_dqs_n;
  (* X_INTERFACE_INFO = "xilinx.com:interface:ddrx:1.0 DDR3 DQS_P" *) inout [7:0]DDR3_dqs_p;
  (* X_INTERFACE_INFO = "xilinx.com:interface:ddrx:1.0 DDR3 ODT" *) output [0:0]DDR3_odt;
  (* X_INTERFACE_INFO = "xilinx.com:interface:ddrx:1.0 DDR3 RAS_N" *) output DDR3_ras_n;
  (* X_INTERFACE_INFO = "xilinx.com:interface:ddrx:1.0 DDR3 RESET_N" *) output DDR3_reset_n;
  (* X_INTERFACE_INFO = "xilinx.com:interface:ddrx:1.0 DDR3 WE_N" *) output DDR3_we_n;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 M_AXIS_MM2S_STS TDATA" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME M_AXIS_MM2S_STS, CLK_DOMAIN bd_ddr_mig_7series_0_0_ui_clk, FREQ_HZ 200000000, HAS_TKEEP 1, HAS_TLAST 1, HAS_TREADY 1, HAS_TSTRB 0, INSERT_VIP 0, LAYERED_METADATA undef, PHASE 0, TDATA_NUM_BYTES 1, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0" *) output [7:0]M_AXIS_MM2S_STS_tdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 M_AXIS_MM2S_STS TKEEP" *) output [0:0]M_AXIS_MM2S_STS_tkeep;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 M_AXIS_MM2S_STS TLAST" *) output M_AXIS_MM2S_STS_tlast;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 M_AXIS_MM2S_STS TREADY" *) input M_AXIS_MM2S_STS_tready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 M_AXIS_MM2S_STS TVALID" *) output M_AXIS_MM2S_STS_tvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 M_AXIS_MM2S TDATA" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME M_AXIS_MM2S, CLK_DOMAIN bd_ddr_mig_7series_0_0_ui_clk, FREQ_HZ 200000000, HAS_TKEEP 1, HAS_TLAST 1, HAS_TREADY 1, HAS_TSTRB 0, INSERT_VIP 0, LAYERED_METADATA undef, PHASE 0, TDATA_NUM_BYTES 8, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0" *) output [63:0]M_AXIS_MM2S_tdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 M_AXIS_MM2S TKEEP" *) output [7:0]M_AXIS_MM2S_tkeep;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 M_AXIS_MM2S TLAST" *) output M_AXIS_MM2S_tlast;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 M_AXIS_MM2S TREADY" *) input M_AXIS_MM2S_tready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 M_AXIS_MM2S TVALID" *) output M_AXIS_MM2S_tvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 M_AXIS_S2MM_STS TDATA" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME M_AXIS_S2MM_STS, CLK_DOMAIN bd_ddr_mig_7series_0_0_ui_clk, FREQ_HZ 200000000, HAS_TKEEP 1, HAS_TLAST 1, HAS_TREADY 1, HAS_TSTRB 0, INSERT_VIP 0, LAYERED_METADATA undef, PHASE 0, TDATA_NUM_BYTES 4, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0" *) output [31:0]M_AXIS_S2MM_STS_tdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 M_AXIS_S2MM_STS TKEEP" *) output [3:0]M_AXIS_S2MM_STS_tkeep;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 M_AXIS_S2MM_STS TLAST" *) output M_AXIS_S2MM_STS_tlast;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 M_AXIS_S2MM_STS TREADY" *) input M_AXIS_S2MM_STS_tready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 M_AXIS_S2MM_STS TVALID" *) output M_AXIS_S2MM_STS_tvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS_MM2S_CMD TDATA" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME S_AXIS_MM2S_CMD, CLK_DOMAIN bd_ddr_mig_7series_0_0_ui_clk, FREQ_HZ 200000000, HAS_TKEEP 0, HAS_TLAST 0, HAS_TREADY 1, HAS_TSTRB 0, INSERT_VIP 0, LAYERED_METADATA undef, PHASE 0, TDATA_NUM_BYTES 9, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0" *) input [71:0]S_AXIS_MM2S_CMD_tdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS_MM2S_CMD TREADY" *) output S_AXIS_MM2S_CMD_tready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS_MM2S_CMD TVALID" *) input S_AXIS_MM2S_CMD_tvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS_S2MM_CMD TDATA" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME S_AXIS_S2MM_CMD, CLK_DOMAIN bd_ddr_mig_7series_0_0_ui_clk, FREQ_HZ 200000000, HAS_TKEEP 0, HAS_TLAST 0, HAS_TREADY 1, HAS_TSTRB 0, INSERT_VIP 0, LAYERED_METADATA undef, PHASE 0, TDATA_NUM_BYTES 9, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0" *) input [71:0]S_AXIS_S2MM_CMD_tdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS_S2MM_CMD TREADY" *) output S_AXIS_S2MM_CMD_tready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS_S2MM_CMD TVALID" *) input S_AXIS_S2MM_CMD_tvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS_S2MM TDATA" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME S_AXIS_S2MM, CLK_DOMAIN bd_ddr_mig_7series_0_0_ui_clk, FREQ_HZ 200000000, HAS_TKEEP 1, HAS_TLAST 1, HAS_TREADY 1, HAS_TSTRB 0, INSERT_VIP 0, LAYERED_METADATA undef, PHASE 0, TDATA_NUM_BYTES 8, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0" *) input [63:0]S_AXIS_S2MM_tdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS_S2MM TKEEP" *) input [7:0]S_AXIS_S2MM_tkeep;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS_S2MM TLAST" *) input S_AXIS_S2MM_tlast;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS_S2MM TREADY" *) output S_AXIS_S2MM_tready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS_S2MM TVALID" *) input S_AXIS_S2MM_tvalid;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK.SYS_CLK CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK.SYS_CLK, ASSOCIATED_RESET sys_rst, CLK_DOMAIN bd_ddr_sys_clk, FREQ_HZ 200000000, INSERT_VIP 0, PHASE 0.000" *) input sys_clk;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 RST.SYS_RST RST" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME RST.SYS_RST, INSERT_VIP 0, POLARITY ACTIVE_HIGH" *) input sys_rst;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK.UI_CLK CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK.UI_CLK, ASSOCIATED_BUSIF S_AXIS_S2MM:S_AXIS_S2MM_CMD:S_AXIS_MM2S_CMD:M_AXIS_S2MM_STS:M_AXIS_MM2S_STS:M_AXIS_MM2S, CLK_DOMAIN bd_ddr_mig_7series_0_0_ui_clk, FREQ_HZ 200000000, INSERT_VIP 0, PHASE 0" *) output ui_clk;

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
  wire [30:0]axi_smc_M00_AXI_ARADDR;
  wire [1:0]axi_smc_M00_AXI_ARBURST;
  wire [3:0]axi_smc_M00_AXI_ARCACHE;
  wire [7:0]axi_smc_M00_AXI_ARLEN;
  wire [0:0]axi_smc_M00_AXI_ARLOCK;
  wire [2:0]axi_smc_M00_AXI_ARPROT;
  wire [3:0]axi_smc_M00_AXI_ARQOS;
  wire axi_smc_M00_AXI_ARREADY;
  wire [2:0]axi_smc_M00_AXI_ARSIZE;
  wire axi_smc_M00_AXI_ARVALID;
  wire [30:0]axi_smc_M00_AXI_AWADDR;
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
  wire [511:0]axi_smc_M00_AXI_RDATA;
  wire axi_smc_M00_AXI_RLAST;
  wire axi_smc_M00_AXI_RREADY;
  wire [1:0]axi_smc_M00_AXI_RRESP;
  wire axi_smc_M00_AXI_RVALID;
  wire [511:0]axi_smc_M00_AXI_WDATA;
  wire axi_smc_M00_AXI_WLAST;
  wire axi_smc_M00_AXI_WREADY;
  wire [63:0]axi_smc_M00_AXI_WSTRB;
  wire axi_smc_M00_AXI_WVALID;
  wire [14:0]mig_7series_0_DDR3_ADDR;
  wire [2:0]mig_7series_0_DDR3_BA;
  wire mig_7series_0_DDR3_CAS_N;
  wire [0:0]mig_7series_0_DDR3_CKE;
  wire [0:0]mig_7series_0_DDR3_CK_N;
  wire [0:0]mig_7series_0_DDR3_CK_P;
  wire [0:0]mig_7series_0_DDR3_CS_N;
  wire [7:0]mig_7series_0_DDR3_DM;
  wire [63:0]mig_7series_0_DDR3_DQ;
  wire [7:0]mig_7series_0_DDR3_DQS_N;
  wire [7:0]mig_7series_0_DDR3_DQS_P;
  wire [0:0]mig_7series_0_DDR3_ODT;
  wire mig_7series_0_DDR3_RAS_N;
  wire mig_7series_0_DDR3_RESET_N;
  wire mig_7series_0_DDR3_WE_N;
  wire mig_7series_0_mmcm_locked;
  wire mig_7series_0_ui_clk;
  wire mig_7series_0_ui_clk_sync_rst;
  wire [0:0]rst_mig_7series_0_200M_peripheral_aresetn;
  wire sys_clk_1;
  wire sys_rst_1;

  assign DDR3_addr[14:0] = mig_7series_0_DDR3_ADDR;
  assign DDR3_ba[2:0] = mig_7series_0_DDR3_BA;
  assign DDR3_cas_n = mig_7series_0_DDR3_CAS_N;
  assign DDR3_ck_n[0] = mig_7series_0_DDR3_CK_N;
  assign DDR3_ck_p[0] = mig_7series_0_DDR3_CK_P;
  assign DDR3_cke[0] = mig_7series_0_DDR3_CKE;
  assign DDR3_cs_n[0] = mig_7series_0_DDR3_CS_N;
  assign DDR3_dm[7:0] = mig_7series_0_DDR3_DM;
  assign DDR3_odt[0] = mig_7series_0_DDR3_ODT;
  assign DDR3_ras_n = mig_7series_0_DDR3_RAS_N;
  assign DDR3_reset_n = mig_7series_0_DDR3_RESET_N;
  assign DDR3_we_n = mig_7series_0_DDR3_WE_N;
  assign M_AXIS_MM2S_STS_tdata[7:0] = axi_datamover_0_M_AXIS_MM2S_STS_TDATA;
  assign M_AXIS_MM2S_STS_tkeep[0] = axi_datamover_0_M_AXIS_MM2S_STS_TKEEP;
  assign M_AXIS_MM2S_STS_tlast = axi_datamover_0_M_AXIS_MM2S_STS_TLAST;
  assign M_AXIS_MM2S_STS_tvalid = axi_datamover_0_M_AXIS_MM2S_STS_TVALID;
  assign M_AXIS_MM2S_tdata[63:0] = axi_datamover_0_M_AXIS_MM2S_TDATA;
  assign M_AXIS_MM2S_tkeep[7:0] = axi_datamover_0_M_AXIS_MM2S_TKEEP;
  assign M_AXIS_MM2S_tlast = axi_datamover_0_M_AXIS_MM2S_TLAST;
  assign M_AXIS_MM2S_tvalid = axi_datamover_0_M_AXIS_MM2S_TVALID;
  assign M_AXIS_S2MM_STS_tdata[31:0] = axi_datamover_0_M_AXIS_S2MM_STS_TDATA;
  assign M_AXIS_S2MM_STS_tkeep[3:0] = axi_datamover_0_M_AXIS_S2MM_STS_TKEEP;
  assign M_AXIS_S2MM_STS_tlast = axi_datamover_0_M_AXIS_S2MM_STS_TLAST;
  assign M_AXIS_S2MM_STS_tvalid = axi_datamover_0_M_AXIS_S2MM_STS_TVALID;
  assign S_AXIS_MM2S_CMD_0_1_TDATA = S_AXIS_MM2S_CMD_tdata[71:0];
  assign S_AXIS_MM2S_CMD_0_1_TVALID = S_AXIS_MM2S_CMD_tvalid;
  assign S_AXIS_MM2S_CMD_tready = S_AXIS_MM2S_CMD_0_1_TREADY;
  assign S_AXIS_S2MM_0_1_TDATA = S_AXIS_S2MM_tdata[63:0];
  assign S_AXIS_S2MM_0_1_TKEEP = S_AXIS_S2MM_tkeep[7:0];
  assign S_AXIS_S2MM_0_1_TLAST = S_AXIS_S2MM_tlast;
  assign S_AXIS_S2MM_0_1_TVALID = S_AXIS_S2MM_tvalid;
  assign S_AXIS_S2MM_CMD_0_1_TDATA = S_AXIS_S2MM_CMD_tdata[71:0];
  assign S_AXIS_S2MM_CMD_0_1_TVALID = S_AXIS_S2MM_CMD_tvalid;
  assign S_AXIS_S2MM_CMD_tready = S_AXIS_S2MM_CMD_0_1_TREADY;
  assign S_AXIS_S2MM_tready = S_AXIS_S2MM_0_1_TREADY;
  assign axi_datamover_0_M_AXIS_MM2S_STS_TREADY = M_AXIS_MM2S_STS_tready;
  assign axi_datamover_0_M_AXIS_MM2S_TREADY = M_AXIS_MM2S_tready;
  assign axi_datamover_0_M_AXIS_S2MM_STS_TREADY = M_AXIS_S2MM_STS_tready;
  assign sys_clk_1 = sys_clk;
  assign sys_rst_1 = sys_rst;
  assign ui_clk = mig_7series_0_ui_clk;
  bd_ddr_axi_datamover_0_0 axi_datamover_0
       (.m_axi_mm2s_aclk(mig_7series_0_ui_clk),
        .m_axi_mm2s_araddr(axi_datamover_0_M_AXI_MM2S_ARADDR),
        .m_axi_mm2s_arburst(axi_datamover_0_M_AXI_MM2S_ARBURST),
        .m_axi_mm2s_arcache(axi_datamover_0_M_AXI_MM2S_ARCACHE),
        .m_axi_mm2s_aresetn(rst_mig_7series_0_200M_peripheral_aresetn),
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
        .m_axi_s2mm_aclk(mig_7series_0_ui_clk),
        .m_axi_s2mm_aresetn(rst_mig_7series_0_200M_peripheral_aresetn),
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
        .m_axis_mm2s_cmdsts_aclk(mig_7series_0_ui_clk),
        .m_axis_mm2s_cmdsts_aresetn(rst_mig_7series_0_200M_peripheral_aresetn),
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
        .m_axis_s2mm_cmdsts_aresetn(rst_mig_7series_0_200M_peripheral_aresetn),
        .m_axis_s2mm_cmdsts_awclk(mig_7series_0_ui_clk),
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
  bd_ddr_axi_smc_0 axi_smc
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
        .aclk(mig_7series_0_ui_clk),
        .aresetn(rst_mig_7series_0_200M_peripheral_aresetn));
  bd_ddr_mig_7series_0_0 mig_7series_0
       (.aresetn(rst_mig_7series_0_200M_peripheral_aresetn),
        .clk_ref_i(sys_clk_1),
        .ddr3_addr(mig_7series_0_DDR3_ADDR),
        .ddr3_ba(mig_7series_0_DDR3_BA),
        .ddr3_cas_n(mig_7series_0_DDR3_CAS_N),
        .ddr3_ck_n(mig_7series_0_DDR3_CK_N),
        .ddr3_ck_p(mig_7series_0_DDR3_CK_P),
        .ddr3_cke(mig_7series_0_DDR3_CKE),
        .ddr3_cs_n(mig_7series_0_DDR3_CS_N),
        .ddr3_dm(mig_7series_0_DDR3_DM),
        .ddr3_dq(DDR3_dq[63:0]),
        .ddr3_dqs_n(DDR3_dqs_n[7:0]),
        .ddr3_dqs_p(DDR3_dqs_p[7:0]),
        .ddr3_odt(mig_7series_0_DDR3_ODT),
        .ddr3_ras_n(mig_7series_0_DDR3_RAS_N),
        .ddr3_reset_n(mig_7series_0_DDR3_RESET_N),
        .ddr3_we_n(mig_7series_0_DDR3_WE_N),
        .mmcm_locked(mig_7series_0_mmcm_locked),
        .s_axi_araddr(axi_smc_M00_AXI_ARADDR),
        .s_axi_arburst(axi_smc_M00_AXI_ARBURST),
        .s_axi_arcache(axi_smc_M00_AXI_ARCACHE),
        .s_axi_arid({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arlen(axi_smc_M00_AXI_ARLEN),
        .s_axi_arlock(axi_smc_M00_AXI_ARLOCK),
        .s_axi_arprot(axi_smc_M00_AXI_ARPROT),
        .s_axi_arqos(axi_smc_M00_AXI_ARQOS),
        .s_axi_arready(axi_smc_M00_AXI_ARREADY),
        .s_axi_arsize(axi_smc_M00_AXI_ARSIZE),
        .s_axi_arvalid(axi_smc_M00_AXI_ARVALID),
        .s_axi_awaddr(axi_smc_M00_AXI_AWADDR),
        .s_axi_awburst(axi_smc_M00_AXI_AWBURST),
        .s_axi_awcache(axi_smc_M00_AXI_AWCACHE),
        .s_axi_awid({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awlen(axi_smc_M00_AXI_AWLEN),
        .s_axi_awlock(axi_smc_M00_AXI_AWLOCK),
        .s_axi_awprot(axi_smc_M00_AXI_AWPROT),
        .s_axi_awqos(axi_smc_M00_AXI_AWQOS),
        .s_axi_awready(axi_smc_M00_AXI_AWREADY),
        .s_axi_awsize(axi_smc_M00_AXI_AWSIZE),
        .s_axi_awvalid(axi_smc_M00_AXI_AWVALID),
        .s_axi_bready(axi_smc_M00_AXI_BREADY),
        .s_axi_bresp(axi_smc_M00_AXI_BRESP),
        .s_axi_bvalid(axi_smc_M00_AXI_BVALID),
        .s_axi_rdata(axi_smc_M00_AXI_RDATA),
        .s_axi_rlast(axi_smc_M00_AXI_RLAST),
        .s_axi_rready(axi_smc_M00_AXI_RREADY),
        .s_axi_rresp(axi_smc_M00_AXI_RRESP),
        .s_axi_rvalid(axi_smc_M00_AXI_RVALID),
        .s_axi_wdata(axi_smc_M00_AXI_WDATA),
        .s_axi_wlast(axi_smc_M00_AXI_WLAST),
        .s_axi_wready(axi_smc_M00_AXI_WREADY),
        .s_axi_wstrb(axi_smc_M00_AXI_WSTRB),
        .s_axi_wvalid(axi_smc_M00_AXI_WVALID),
        .sys_clk_i(sys_clk_1),
        .sys_rst(sys_rst_1),
        .ui_clk(mig_7series_0_ui_clk),
        .ui_clk_sync_rst(mig_7series_0_ui_clk_sync_rst));
  bd_ddr_rst_mig_7series_0_200M_0 rst_mig_7series_0_200M
       (.aux_reset_in(1'b1),
        .dcm_locked(mig_7series_0_mmcm_locked),
        .ext_reset_in(mig_7series_0_ui_clk_sync_rst),
        .mb_debug_sys_rst(1'b0),
        .peripheral_aresetn(rst_mig_7series_0_200M_peripheral_aresetn),
        .slowest_sync_clk(mig_7series_0_ui_clk));
endmodule
