`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/10/17 14:55:45
// Design Name: 
// Module Name: ddr_top
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
module ddr_top #(
    parameter                           MM2S_DATA_WIDTH = 64,
    parameter                           S2MM_DATA_WIDTH = 64,
    parameter                           MM2S_CMD_WIDTH  = 72,
    parameter                           S2MM_CMD_WIDTH  = 72,
    parameter                           MM2S_STS_WIDTH  = 8 ,
    parameter                           S2MM_STS_WIDTH  = 32,
    parameter                           ADDR_WIDTH      = 32,
    parameter                           LEN_WIDTH       = 16
)(
    // >>>>>>>>>> sys
    input                               clk                 ,
    input                               rstn                ,
    // >>>>>>>>>> usr
    input                               wstart              ,
    output                              wready              ,
    input   [ADDR_WIDTH-1 : 0]          waddr               ,
    input   [LEN_WIDTH-1 : 0]           wdata_len           ,
    input                               wdata_vld           ,
    input   [S2MM_DATA_WIDTH-1 : 0]     wdata               ,
    input                               rstart              ,
    output                              rready              ,
    input   [ADDR_WIDTH-1 : 0]          raddr               ,
    input   [LEN_WIDTH-1 : 0]           rdata_len           ,
    output                              rdata_vld           ,
    output  [MM2S_DATA_WIDTH-1 : 0]     rdata               ,
    // >>>>>>>>>> ddr
    input                               ddr4_clk_p          ,
    input                               ddr4_clk_n          ,
    output                              ddr4_init_done      ,
    output                              ddr4_rtl_act_n      ,
    output                              ddr4_rtl_adr        ,
    output                              ddr4_rtl_ba         ,
    output                              ddr4_rtl_bg         ,
    output                              ddr4_rtl_ck_c       ,
    output                              ddr4_rtl_ck_t       ,
    output                              ddr4_rtl_cke        ,
    output                              ddr4_rtl_cs_n       ,
    inout                               ddr4_rtl_dm_n       ,
    inout                               ddr4_rtl_dq         ,
    inout                               ddr4_rtl_dqs_c      ,
    inout                               ddr4_rtl_dqs_t      ,
    output                              ddr4_rtl_odt
    );

// >>>>>>>>>> var
wire    [MM2S_STS_WIDTH-1 : 0]          mm2s_sts_tdata;
wire    [(MM2S_STS_WIDTH/8)-1 : 0]      mm2s_sts_tkeep;
wire                                    mm2s_sts_tlast;
wire                                    mm2s_sts_tready;
wire                                    mm2s_sts_tvalid;
wire    [S2MM_CMD_WIDTH-1 : 0]          mm2s_cmd_tdata;
wire                                    mm2s_cmd_tready;
wire                                    mm2s_cmd_tvalid;
wire    [MM2S_DATA_WIDTH-1 : 0]         mm2s_tdata;
wire    [(MM2S_DATA_WIDTH/8)-1 : 0]     mm2s_tkeep;
wire                                    mm2s_tlast;
wire                                    mm2s_tready;
wire                                    mm2s_tvalid;
wire    [S2MM_STS_WIDTH-1 : 0]          s2mm_sts_tdata;
wire    [(S2MM_STS_WIDTH/8)-1 : 0]      s2mm_sts_tkeep;
wire                                    s2mm_sts_tlast;
wire                                    s2mm_sts_tready;
wire                                    s2mm_sts_tvalid;
wire    [S2MM_CMD_WIDTH-1 : 0]          s2mm_cmd_tdata;
wire                                    s2mm_cmd_tready;
wire                                    s2mm_cmd_tvalid;
wire    [S2MM_DATA_WIDTH-1 : 0]         s2mm_tdata;
wire    [(S2MM_DATA_WIDTH/8)-1 : 0]     s2mm_tkeep;
wire                                    s2mm_tlast;
wire                                    s2mm_tready;
wire                                    s2mm_tvalid;

// >>>>>>>>>> axi_datamover_ctrl
axi_datamover_write #(
    .DATA_WIDTH                     (S2MM_DATA_WIDTH                ),
    .CMD_WIDTH                      (S2MM_CMD_WIDTH                 ),
    .ADDR_WIDTH                     (ADDR_WIDTH                     ),
    .LEN_WIDTH                      (LEN_WIDTH                      ),
    .STS_WIDTH                      (S2MM_STS_WIDTH                 )
)
u_axi_datamover_write (
    .clk                            (clk                            ),
    .rstn                           (rstn                           ),
    .start                          (wstart                         ),
    .wready                         (wready                         ),
    .waddr                          (waddr                          ),
    .wdata_len                      (wdata_len                      ),
    .wdata_vld                      (wdata_vld                      ),
    .wdata                          (wdata                          ),
    .s2mm_cmd_tdata                 (s2mm_cmd_tdata                 ),
    .s2mm_cmd_tready                (s2mm_cmd_tready                ),
    .s2mm_cmd_tvalid                (s2mm_cmd_tvalid                ),
    .s2mm_tdata                     (s2mm_tdata                     ),
    .s2mm_tkeep                     (s2mm_tkeep                     ),
    .s2mm_tlast                     (s2mm_tlast                     ),
    .s2mm_tready                    (s2mm_tready                    ),
    .s2mm_tvalid                    (s2mm_tvalid                    ),
    .s2mm_sts_tdata                 (s2mm_sts_tdata                 ),
    .s2mm_sts_tkeep                 (s2mm_sts_tkeep                 ),
    .s2mm_sts_tlast                 (s2mm_sts_tlast                 ),
    .s2mm_sts_tready                (s2mm_sts_tready                ),
    .s2mm_sts_tvalid                (s2mm_sts_tvalid                )
    );

axi_datamover_read #(
    .DATA_WIDTH                     (MM2S_DATA_WIDTH                ),
    .CMD_WIDTH                      (MM2S_CMD_WIDTH                 ),
    .ADDR_WIDTH                     (ADDR_WIDTH                     ),
    .LEN_WIDTH                      (LEN_WIDTH                      ),
    .STS_WIDTH                      (MM2S_STS_WIDTH                 )
)
u_axi_datamover_read (
    .clk                            (clk                            ),
    .rstn                           (rstn                           ),
    .start                          (rstart                         ),
    .rready                         (rready                         ),
    .raddr                          (raddr                          ),
    .rdata_len                      (rdata_len                      ),
    .rdata_vld                      (rdata_vld                      ),
    .rdata                          (rdata                          ),
    .mm2s_cmd_tdata                 (mm2s_cmd_tdata                 ),
    .mm2s_cmd_tready                (mm2s_cmd_tready                ),
    .mm2s_cmd_tvalid                (mm2s_cmd_tvalid                ),
    .mm2s_tdata                     (mm2s_tdata                     ),
    .mm2s_tkeep                     (mm2s_tkeep                     ),
    .mm2s_tlast                     (mm2s_tlast                     ),
    .mm2s_tready                    (mm2s_tready                    ),
    .mm2s_tvalid                    (mm2s_tvalid                    ),
    .mm2s_sts_tdata                 (mm2s_sts_tdata                 ),
    .mm2s_sts_tkeep                 (mm2s_sts_tkeep                 ),
    .mm2s_sts_tlast                 (mm2s_sts_tlast                 ),
    .mm2s_sts_tready                (mm2s_sts_tready                ),
    .mm2s_sts_tvalid                (mm2s_sts_tvalid                )
    );

// >>>>>>>>>> bd_ddr
bd_wrapper u_bd_wrapper (
    .M_AXIS_MM2S_0_tdata            (mm2s_tdata                     ),
    .M_AXIS_MM2S_0_tkeep            (mm2s_tkeep                     ),
    .M_AXIS_MM2S_0_tlast            (mm2s_tlast                     ),
    .M_AXIS_MM2S_0_tready           (mm2s_tready                    ),
    .M_AXIS_MM2S_0_tvalid           (mm2s_tvalid                    ),
    .M_AXIS_MM2S_STS_0_tdata        (mm2s_sts_tdata                 ),
    .M_AXIS_MM2S_STS_0_tkeep        (mm2s_sts_tkeep                 ),
    .M_AXIS_MM2S_STS_0_tlast        (mm2s_sts_tlast                 ),
    .M_AXIS_MM2S_STS_0_tready       (mm2s_sts_tready                ),
    .M_AXIS_MM2S_STS_0_tvalid       (mm2s_sts_tvalid                ),
    .M_AXIS_S2MM_STS_0_tdata        (s2mm_sts_tdata                 ),
    .M_AXIS_S2MM_STS_0_tkeep        (s2mm_sts_tkeep                 ),
    .M_AXIS_S2MM_STS_0_tlast        (s2mm_sts_tlast                 ),
    .M_AXIS_S2MM_STS_0_tready       (s2mm_sts_tready                ),
    .M_AXIS_S2MM_STS_0_tvalid       (s2mm_sts_tvalid                ),
    .S_AXIS_MM2S_CMD_0_tdata        (mm2s_cmd_tdata                 ),
    .S_AXIS_MM2S_CMD_0_tready       (mm2s_cmd_tready                ),
    .S_AXIS_MM2S_CMD_0_tvalid       (mm2s_cmd_tvalid                ),
    .S_AXIS_S2MM_0_tdata            (s2mm_tdata                     ),
    .S_AXIS_S2MM_0_tkeep            (s2mm_tkeep                     ),
    .S_AXIS_S2MM_0_tlast            (s2mm_tlast                     ),
    .S_AXIS_S2MM_0_tready           (s2mm_tready                    ),
    .S_AXIS_S2MM_0_tvalid           (s2mm_tvalid                    ),
    .S_AXIS_S2MM_CMD_0_tdata        (s2mm_cmd_tdata                 ),
    .S_AXIS_S2MM_CMD_0_tready       (s2mm_cmd_tready                ),
    .S_AXIS_S2MM_CMD_0_tvalid       (s2mm_cmd_tvalid                ),
    .ddr4_init_done                 (ddr4_init_done                 ),
    .ddr4_rtl_act_n                 (ddr4_rtl_act_n                 ),
    .ddr4_rtl_adr                   (ddr4_rtl_adr                   ),
    .ddr4_rtl_ba                    (ddr4_rtl_ba                    ),
    .ddr4_rtl_bg                    (ddr4_rtl_bg                    ),
    .ddr4_rtl_ck_c                  (ddr4_rtl_ck_c                  ),
    .ddr4_rtl_ck_t                  (ddr4_rtl_ck_t                  ),
    .ddr4_rtl_cke                   (ddr4_rtl_cke                   ),
    .ddr4_rtl_cs_n                  (ddr4_rtl_cs_n                  ),
    .ddr4_rtl_dm_n                  (ddr4_rtl_dm_n                  ),
    .ddr4_rtl_dq                    (ddr4_rtl_dq                    ),
    .ddr4_rtl_dqs_c                 (ddr4_rtl_dqs_c                 ),
    .ddr4_rtl_dqs_t                 (ddr4_rtl_dqs_t                 ),
    .ddr4_rtl_odt                   (ddr4_rtl_odt                   ),
    .ddr4_rtl_reset_n               (ddr4_rtl_reset_n               ),
    .ddr4_clk_clk_n                 (ddr4_clk_n                     ),
    .ddr4_clk_clk_p                 (ddr4_clk_p                     ),
    .sys_clk                        (clk                            ),
    .sys_rst                        (~rstn                          )
);

endmodule
