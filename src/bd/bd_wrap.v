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
module bd_wrap #(
    parameter                           CFG_ADDR_WIDTH  = 32,
    parameter                           CFG_DATA_WIDTH  = 32,
    parameter                           S2MM_DATA_WIDTH = 64,
    parameter                           S2MM_CMD_WIDTH  = 72,
    parameter                           S2MM_ADDR_WIDTH = 32,
    parameter                           S2MM_SIZE_WIDTH = 16,
    parameter                           S2MM_STS_WIDTH  = 32,
    parameter                           MM2S_DATA_WIDTH = 64,
    parameter                           MM2S_CMD_WIDTH  = 72,
    parameter                           MM2S_ADDR_WIDTH = 32,
    parameter                           MM2S_SIZE_WIDTH = 16,
    parameter                           MM2S_STS_WIDTH  = 8
)(
    // >>>>>>>>>> sys
    output                              ps_clk_100m         ,
    output                              ps_clk_125m         ,
    output                              ps_clk_250m         ,
    output                              ps_clk_300m         ,
    output                              ps_rstn             ,
    // >>>>>>>>>> bram_cfg
    output                              bram_cfg_clk        ,
    output                              bram_cfg_rst        ,
    output  [CFG_ADDR_WIDTH-1:0]        bram_cfg_addr       ,
    output  [CFG_DATA_WIDTH-1:0]        bram_cfg_data       ,
    input   [CFG_DATA_WIDTH-1:0]        bram_cfg_rdbk       ,
    output                              bram_cfg_en         ,
    output  [CFG_DATA_WIDTH/8-1:0]      bram_cfg_we         ,
    // >>>>>>>>>> ddr_write
    output                              ddr_wreq_ready      ,
    input                               ddr_wreq_valid      ,
    input   [S2MM_ADDR_WIDTH-1:0]       ddr_wreq_addr       ,
    input   [S2MM_SIZE_WIDTH-1:0]       ddr_wreq_size       ,
    output                              ddr_wdata_ready     ,
    input                               ddr_wdata_valid     ,
    input                               ddr_wdata_last      ,
    input   [S2MM_DATA_WIDTH-1:0]       ddr_wdata           ,
    output                              ddr_wresp_valid     ,
    output  [1:0]                       ddr_wresp           ,
    // >>>>>>>>>> ddr_read
    output                              ddr_rreq_ready      ,
    input                               ddr_rreq_valid      ,
    input   [MM2S_ADDR_WIDTH-1:0]       ddr_rreq_addr       ,
    input   [MM2S_SIZE_WIDTH-1:0]       ddr_rreq_size       ,
    input                               ddr_rdata_ready     ,
    output                              ddr_rdata_valid     ,
    output                              ddr_rdata_last      ,
    output  [MM2S_DATA_WIDTH-1:0]       ddr_rdata           ,
    output                              ddr_rresp_valid     ,
    output  [1:0]                       ddr_rresp
    );

// >>>>>>>>>> param
localparam                              AXIS_FIFO_DEPTH = 32;

// >>>>>>>>>> var
wire    [MM2S_STS_WIDTH-1:0]            mm2s_sts_tdata;
wire    [MM2S_STS_WIDTH/8-1:0]          mm2s_sts_tkeep;
wire                                    mm2s_sts_tlast;
wire                                    mm2s_sts_tready;
wire                                    mm2s_sts_tvalid;
wire    [MM2S_CMD_WIDTH-1:0]            mm2s_cmd_tdata;
wire                                    mm2s_cmd_tready;
wire                                    mm2s_cmd_tvalid;
wire    [MM2S_DATA_WIDTH-1:0]           mm2s_tdata;
wire    [MM2S_DATA_WIDTH/8-1:0]         mm2s_tkeep;
wire                                    mm2s_tlast;
wire                                    mm2s_tready;
wire                                    mm2s_tvalid;
wire    [S2MM_STS_WIDTH-1:0]            s2mm_sts_tdata;
wire    [S2MM_STS_WIDTH/8-1:0]          s2mm_sts_tkeep;
wire                                    s2mm_sts_tlast;
wire                                    s2mm_sts_tready;
wire                                    s2mm_sts_tvalid;
wire    [S2MM_CMD_WIDTH-1:0]            s2mm_cmd_tdata;
wire                                    s2mm_cmd_tready;
wire                                    s2mm_cmd_tvalid;
wire    [S2MM_DATA_WIDTH-1:0]           s2mm_tdata;
wire    [S2MM_DATA_WIDTH/8-1:0]         s2mm_tkeep;
wire                                    s2mm_tlast;
wire                                    s2mm_tready;
wire                                    s2mm_tvalid;
wire    [28:0]                          tmp_bram_cfg_addr;

// >>>>>>>>>> axi_datamover_ctrl
axi_datamover_write #(
    .AXIS_FIFO_DEPTH                (AXIS_FIFO_DEPTH        ),
    .S2MM_DATA_WIDTH                (S2MM_DATA_WIDTH        ),
    .S2MM_CMD_WIDTH                 (S2MM_CMD_WIDTH         ),
    .S2MM_ADDR_WIDTH                (S2MM_ADDR_WIDTH        ),
    .S2MM_SIZE_WIDTH                (S2MM_SIZE_WIDTH        ),
    .S2MM_STS_WIDTH                 (S2MM_STS_WIDTH         )
)
u_axis_datamover_write (
    .clk                            (ps_clk_250m            ),
    .rstn                           (ps_rstn                ),
    .ddr_wreq_ready                 (ddr_wreq_ready         ),
    .ddr_wreq_valid                 (ddr_wreq_valid         ),
    .ddr_wreq_addr                  (ddr_wreq_addr          ),
    .ddr_wreq_size                  (ddr_wreq_size          ),
    .ddr_wdata_ready                (ddr_wdata_ready        ),
    .ddr_wdata_valid                (ddr_wdata_valid        ),
    .ddr_wdata_last                 (ddr_wdata_last         ),
    .ddr_wdata                      (ddr_wdata              ),
    .ddr_wresp_valid                (ddr_wresp_valid        ),
    .ddr_wresp                      (ddr_wresp              ),
    .s2mm_cmd_tdata                 (s2mm_cmd_tdata         ),
    .s2mm_cmd_tready                (s2mm_cmd_tready        ),
    .s2mm_cmd_tvalid                (s2mm_cmd_tvalid        ),
    .s2mm_tdata                     (s2mm_tdata             ),
    .s2mm_tkeep                     (s2mm_tkeep             ),
    .s2mm_tlast                     (s2mm_tlast             ), 
    .s2mm_tready                    (s2mm_tready            ),
    .s2mm_tvalid                    (s2mm_tvalid            ),
    .s2mm_sts_tdata                 (s2mm_sts_tdata         ),
    .s2mm_sts_tkeep                 (s2mm_sts_tkeep         ),
    .s2mm_sts_tlast                 (s2mm_sts_tlast         ),
    .s2mm_sts_tready                (s2mm_sts_tready        ),
    .s2mm_sts_tvalid                (s2mm_sts_tvalid        )
    );

axi_datamover_read #(
    .AXIS_FIFO_DEPTH                (AXIS_FIFO_DEPTH        ),
    .MM2S_DATA_WIDTH                (MM2S_DATA_WIDTH        ),
    .MM2S_CMD_WIDTH                 (MM2S_CMD_WIDTH         ),
    .MM2S_ADDR_WIDTH                (MM2S_ADDR_WIDTH        ),
    .MM2S_SIZE_WIDTH                (MM2S_SIZE_WIDTH        ),
    .MM2S_STS_WIDTH                 (MM2S_STS_WIDTH         )
)
u_axi_datamover_read (
    .clk                            (ps_clk_250m            ),
    .rstn                           (ps_rstn                ),
    .ddr_rreq_ready                 (ddr_rreq_ready         ),
    .ddr_rreq_valid                 (ddr_rreq_valid         ),
    .ddr_rreq_addr                  (ddr_rreq_addr          ),
    .ddr_rreq_size                  (ddr_rreq_size          ),
    .ddr_rdata_ready                (ddr_rdata_ready        ),
    .ddr_rdata_valid                (ddr_rdata_valid        ),
    .ddr_rdata_last                 (ddr_rdata_last         ),
    .ddr_rdata                      (ddr_rdata              ),
    .ddr_rresp_valid                (ddr_rresp_valid        ),
    .ddr_rresp                      (ddr_rresp              ),
    .mm2s_cmd_tdata                 (mm2s_cmd_tdata         ),
    .mm2s_cmd_tready                (mm2s_cmd_tready        ),
    .mm2s_cmd_tvalid                (mm2s_cmd_tvalid        ),
    .mm2s_tdata                     (mm2s_tdata             ),
    .mm2s_tkeep                     (mm2s_tkeep             ),
    .mm2s_tlast                     (mm2s_tlast             ), 
    .mm2s_tready                    (mm2s_tready            ),
    .mm2s_tvalid                    (mm2s_tvalid            ),
    .mm2s_sts_tdata                 (mm2s_sts_tdata         ),
    .mm2s_sts_tkeep                 (mm2s_sts_tkeep         ),
    .mm2s_sts_tlast                 (mm2s_sts_tlast         ),
    .mm2s_sts_tready                (mm2s_sts_tready        ),
    .mm2s_sts_tvalid                (mm2s_sts_tvalid        )
    );

// >>>>>>>>>> bd_ddr
assign bram_cfg_addr    = tmp_bram_cfg_addr;

design_1_wrapper u_design_1_wrapper (
    .BRAM_PORTA_0_addr              (tmp_bram_cfg_addr      ),
    .BRAM_PORTA_0_clk               (bram_cfg_clk           ),
    .BRAM_PORTA_0_din               (bram_cfg_data          ),
    .BRAM_PORTA_0_dout              (bram_cfg_rdbk          ),
    .BRAM_PORTA_0_en                (bram_cfg_en            ),
    .BRAM_PORTA_0_rst               (bram_cfg_rst           ),
    .BRAM_PORTA_0_we                (bram_cfg_we            ),
    .M_AXIS_MM2S_0_tdata            (mm2s_tdata             ),
    .M_AXIS_MM2S_0_tkeep            (mm2s_tkeep             ),
    .M_AXIS_MM2S_0_tlast            (mm2s_tlast             ),
    .M_AXIS_MM2S_0_tready           (mm2s_tready            ),
    .M_AXIS_MM2S_0_tvalid           (mm2s_tvalid            ),
    .M_AXIS_MM2S_STS_0_tdata        (mm2s_sts_tdata         ),
    .M_AXIS_MM2S_STS_0_tkeep        (mm2s_sts_tkeep         ),
    .M_AXIS_MM2S_STS_0_tlast        (mm2s_sts_tlast         ),
    .M_AXIS_MM2S_STS_0_tready       (mm2s_sts_tready        ),
    .M_AXIS_MM2S_STS_0_tvalid       (mm2s_sts_tvalid        ),
    .M_AXIS_S2MM_STS_0_tdata        (s2mm_sts_tdata         ),
    .M_AXIS_S2MM_STS_0_tkeep        (s2mm_sts_tkeep         ),
    .M_AXIS_S2MM_STS_0_tlast        (s2mm_sts_tlast         ),
    .M_AXIS_S2MM_STS_0_tready       (s2mm_sts_tready        ),
    .M_AXIS_S2MM_STS_0_tvalid       (s2mm_sts_tvalid        ),
    .S_AXIS_MM2S_CMD_0_tdata        (mm2s_cmd_tdata         ),
    .S_AXIS_MM2S_CMD_0_tready       (mm2s_cmd_tready        ),
    .S_AXIS_MM2S_CMD_0_tvalid       (mm2s_cmd_tvalid        ),
    .S_AXIS_S2MM_0_tdata            (s2mm_tdata             ),
    .S_AXIS_S2MM_0_tkeep            (s2mm_tkeep             ),
    .S_AXIS_S2MM_0_tlast            (s2mm_tlast             ),
    .S_AXIS_S2MM_0_tready           (s2mm_tready            ),
    .S_AXIS_S2MM_0_tvalid           (s2mm_tvalid            ),
    .S_AXIS_S2MM_CMD_0_tdata        (s2mm_cmd_tdata         ),
    .S_AXIS_S2MM_CMD_0_tready       (s2mm_cmd_tready        ),
    .S_AXIS_S2MM_CMD_0_tvalid       (s2mm_cmd_tvalid        ),
    .mm2s_err_0                     (                       ),
    .s2mm_err_0                     (                       ),
    .pl_clk0_0                      (ps_clk_100m            ),
    .pl_clk1_0                      (ps_clk_125m            ),
    .pl_clk2_0                      (ps_clk_250m            ),
    .pl_clk3_0                      (ps_clk_300m            ),
    .pl_resetn0_0                   (ps_rstn                )
);

endmodule
