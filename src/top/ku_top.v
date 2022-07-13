`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/10/17 14:55:01
// Design Name: 
// Module Name: ku_top
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
module ku_top(
    // >>>>>>>>>> sys
    input                               clk_200m            ,
    input                               clk_156p25m_p       ,
    input                               clk_156p25m_n       ,
    input                               rstn                ,
    // >>>>>>>>>> ddr
    input                               ddr4_clk_n          ,
    input                               ddr4_clk_p          ,
    output                              ddr4_init_done      ,
    output                              ddr4_rtl_act_n      ,
    output  [16 : 0]                    ddr4_rtl_adr        ,
    output  [1 : 0]                     ddr4_rtl_ba         ,
    output                              ddr4_rtl_bg         ,
    output                              ddr4_rtl_ck_c       ,
    output                              ddr4_rtl_ck_t       ,
    output                              ddr4_rtl_cke        ,
    output                              ddr4_rtl_cs_n       ,
    inout                               ddr4_rtl_dm_n       ,
    inout   [7 : 0]                     ddr4_rtl_dq         ,
    inout                               ddr4_rtl_dqs_c      ,
    inout                               ddr4_rtl_dqs_t      ,
    output                              ddr4_rtl_odt        ,
    output                              ddr4_rtl_reset_n    ,
    // >>>>>>>>>> net tx & rx
    output                              txp                 ,
    output                              txn                 ,
    input                               rxp                 ,
    input                               rxn
    );

// >>>>>>>>>> param
// ddr
localparam                              MM2S_DATA_WIDTH     = 64;
localparam                              S2MM_DATA_WIDTH     = 64;
localparam                              MM2S_CMD_WIDTH      = 72;
localparam                              S2MM_CMD_WIDTH      = 72;
localparam                              MM2S_STS_WIDTH      = 8 ;
localparam                              S2MM_STS_WIDTH      = 32;
localparam                              ADDR_WIDTH          = 32;
localparam                              LEN_WIDTH           = 16;
// net
localparam                              S_AXI_ADDR_WIDTH    = 11;
localparam                              S_AXI_DATA_WIDTH    = 32;
localparam                              AXIS_DATA_WIDTH     = 64;
localparam                              REG_ADDR_WIDTH      = 32;
localparam                              REG_DATA_WIDTH      = 32;

// >>>>>>>>>> var
// ddr
wire                                    wstart;
wire                                    wready;
wire    [ADDR_WIDTH-1 : 0]              waddr;
wire    [LEN_WIDTH-1 : 0]               wdata_len;
wire                                    wdata_vld;
wire    [S2MM_DATA_WIDTH-1 : 0]         wdata;
wire                                    rstart;
wire                                    rready;
wire    [ADDR_WIDTH-1 : 0]              raddr;
wire    [LEN_WIDTH-1 : 0]               rdata_len;
wire                                    rdata_vld;
wire    [MM2S_DATA_WIDTH-1 : 0]         rdata;
// net
wire                                    coreclk;
wire                                    eth_en, eth_init_done, eth_rst_done;
wire                                    usr_cfg_type, usr_wr_en, usr_rd_en, usr_rd_vld;
wire    [REG_ADDR_WIDTH-1 : 0]          usr_wr_addr, usr_rd_addr;
wire    [REG_DATA_WIDTH-1 : 0]          usr_wr_data, usr_rd_data;
wire    [LEN_WIDTH-1 : 0]               tx_size;
wire    [AXIS_DATA_WIDTH-1 : 0]         tx_axis_tdata, rx_axis_tdata;
wire    [AXIS_DATA_WIDTH/8-1 : 0]       tx_axis_tkeep, rx_axis_tkeep;
wire                                    tx_axis_tvalid, tx_axis_tlast, tx_axis_tready, rx_axis_tvalid, rx_axis_tlast, rx_axis_tready;
wire    [47 : 0]                        local_addr, remote_addr;
// test
wire                                    test_tx_data_en, test_cfg_type, test_cfg_wr_en, test_cfg_rd_en;
wire    [REG_ADDR_WIDTH-1 : 0]          test_cfg_wr_addr, test_cfg_rd_addr;
wire    [REG_DATA_WIDTH-1 : 0]          test_cfg_wr_data, test_cfg_rd_data;

// >>>>>>>>>> test_gen
assign local_addr   = 48'h1000;
assign remote_addr  = 48'h2000;

test_data_gen #(
    .WDATA_WIDTH                (S2MM_DATA_WIDTH        ),
    .RDATA_WIDTH                (MM2S_DATA_WIDTH        ),
    .ADDR_WIDTH                 (ADDR_WIDTH             ),
    .LEN_WIDTH                  (LEN_WIDTH              )
)
u_test_data_gen (
    .clk                        (clk_200m               ),
    .rstn                       (rstn                   ),
    .test_en                    (ddr4_init_done         ),
    .wstart                     (wstart                 ),
    .wready                     (wready                 ),
    .waddr                      (waddr                  ),
    .wdata_len                  (wdata_len              ),
    .wdata_vld                  (wdata_vld              ),
    .wdata                      (wdata                  ),
    .rstart                     (rstart                 ),
    .rready                     (rready                 ),
    .raddr                      (raddr                  ),
    .rdata_len                  (rdata_len              ),
    .rdata_vld                  (rdata_vld              ),
    .rdata                      (rdata                  )
    );

test_axis_data_gen #(
    .AXIS_DATA_WIDTH            (AXIS_DATA_WIDTH        )
)
u_test_axis_data_gen (
    .clk                        (coreclk                ),
    .rstn                       (rstn                   ),
    .test_en                    (test_tx_data_en        ),
    .tx_size                    (tx_size                ),
    .tx_axis_tdata              (tx_axis_tdata          ),
    .tx_axis_tkeep              (tx_axis_tkeep          ),
    .tx_axis_tvalid             (tx_axis_tvalid         ),
    .tx_axis_tlast              (tx_axis_tlast          ),
    .tx_axis_tready             (tx_axis_tready         ),
    .rx_axis_tdata              (rx_axis_tdata          ),
    .rx_axis_tkeep              (rx_axis_tkeep          ),
    .rx_axis_tvalid             (rx_axis_tvalid         ),
    .rx_axis_tlast              (rx_axis_tlast          ),
    .rx_axis_tready             (rx_axis_tready         )
    );

test_cfg #(
    .REG_ADDR_WIDTH             (REG_ADDR_WIDTH         ),
    .REG_DATA_WIDTH             (REG_DATA_WIDTH         )
)
u_test_cfg (
    .clk                        (clk_200m               ),
    .rstn                       (rstn                   ),
    .eth_lock                   (eth_rst_done           ),
    .eth_en                     (eth_en                 ),
    .eth_init_done              (eth_init_done          ),
    .test_cfg_type              (test_cfg_type          ),
    .test_cfg_wr_en             (test_cfg_wr_en         ),
    .test_cfg_wr_addr           (test_cfg_wr_addr       ),
    .test_cfg_wr_data           (test_cfg_wr_data       ),
    .test_cfg_rd_en             (test_cfg_rd_en         ),
    .test_cfg_rd_addr           (test_cfg_rd_addr       ),
    .test_cfg_rd_data           (test_cfg_rd_data       ),
    .usr_cfg_type               (usr_cfg_type           ),
    .usr_wr_en                  (usr_wr_en              ),
    .usr_wr_addr                (usr_wr_addr            ),
    .usr_wr_data                (usr_wr_data            ),
    .usr_rd_en                  (usr_rd_en              ),
    .usr_rd_addr                (usr_rd_addr            ),
    .usr_rd_vld                 (usr_rd_vld             ),
    .usr_rd_data                (usr_rd_data            )
    );

// >>>>>>>>>> ddr4_top
ddr_wrap #(
    .MM2S_DATA_WIDTH            (MM2S_DATA_WIDTH        ),
    .S2MM_DATA_WIDTH            (S2MM_DATA_WIDTH        ),
    .MM2S_CMD_WIDTH             (MM2S_CMD_WIDTH         ),
    .S2MM_CMD_WIDTH             (S2MM_CMD_WIDTH         ),
    .MM2S_STS_WIDTH             (MM2S_STS_WIDTH         ),
    .S2MM_STS_WIDTH             (S2MM_STS_WIDTH         ),
    .ADDR_WIDTH                 (ADDR_WIDTH             ),
    .LEN_WIDTH                  (LEN_WIDTH              )
)
u_ddr_wrap (
    .clk                        (clk_200m               ),
    .rstn                       (rstn                   ),
    .wstart                     (wstart                 ),
    .wready                     (wready                 ),
    .waddr                      (waddr                  ),
    .wdata_len                  (wdata_len              ),
    .wdata_vld                  (wdata_vld              ),
    .wdata                      (wdata                  ),
    .rstart                     (rstart                 ),
    .rready                     (rready                 ),
    .raddr                      (raddr                  ),
    .rdata_len                  (rdata_len              ),
    .rdata_vld                  (rdata_vld              ),
    .rdata                      (rdata                  ),
    .ddr4_clk_p                 (ddr4_clk_p             ),
    .ddr4_clk_n                 (ddr4_clk_n             ),
    .ddr4_init_done             (ddr4_init_done         ),
    .ddr4_rtl_act_n             (ddr4_rtl_act_n         ),
    .ddr4_rtl_adr               (ddr4_rtl_adr           ),
    .ddr4_rtl_ba                (ddr4_rtl_ba            ),
    .ddr4_rtl_bg                (ddr4_rtl_bg            ),
    .ddr4_rtl_ck_c              (ddr4_rtl_ck_c          ),
    .ddr4_rtl_ck_t              (ddr4_rtl_ck_t          ),
    .ddr4_rtl_cke               (ddr4_rtl_cke           ),
    .ddr4_rtl_cs_n              (ddr4_rtl_cs_n          ),
    .ddr4_rtl_dm_n              (ddr4_rtl_dm_n          ),
    .ddr4_rtl_dq                (ddr4_rtl_dq            ),
    .ddr4_rtl_dqs_c             (ddr4_rtl_dqs_c         ),
    .ddr4_rtl_dqs_t             (ddr4_rtl_dqs_t         ),
    .ddr4_rtl_odt               (ddr4_rtl_odt           ),
    .ddr4_rtl_reset_n           (ddr4_rtl_reset_n       )
    );

// >>>>>>>>>> eth_wrap
eth_wrap #(
    .S_AXI_ADDR_WIDTH           (S_AXI_ADDR_WIDTH       ),
    .S_AXI_DATA_WIDTH           (S_AXI_DATA_WIDTH       ),
    .AXIS_DATA_WIDTH            (AXIS_DATA_WIDTH        ),
    .REG_ADDR_WIDTH             (REG_ADDR_WIDTH         ),
    .REG_DATA_WIDTH             (REG_DATA_WIDTH         )
)
u_eth_wrap (
    .refclk_p                   (clk_156p25m_p          ),
    .refclk_n                   (clk_156p25m_n          ),
    .rstn                       (rstn                   ),
    .coreclk                    (coreclk                ),
    .s_axi_aclk                 (clk_200m               ),
    .s_axi_aresetn              (rstn                   ),
    .eth_en                     (eth_en                 ),
    .eth_init_done              (eth_init_done          ),
    .eth_rst_done               (eth_rst_done           ),
    .local_addr                 (local_addr             ),
    .remote_addr                (remote_addr            ),
    .tx_size                    (tx_size                ),
    .rx_size                    (tx_size                ),
    .usr_cfg_type               (usr_cfg_type           ),
    .usr_wr_en                  (usr_wr_en              ),
    .usr_wr_addr                (usr_wr_addr            ),
    .usr_wr_data                (usr_wr_data            ),
    .usr_rd_en                  (usr_rd_en              ),
    .usr_rd_addr                (usr_rd_addr            ),
    .usr_rd_vld                 (usr_rd_vld             ),
    .usr_rd_data                (usr_rd_data            ),
    .tx_axis_tdata              (tx_axis_tdata          ),
    .tx_axis_tkeep              (tx_axis_tkeep          ),
    .tx_axis_tvalid             (tx_axis_tvalid         ),
    .tx_axis_tlast              (tx_axis_tlast          ),
    .tx_axis_tready             (tx_axis_tready         ),
    .rx_axis_tdata              (rx_axis_tdata          ),
    .rx_axis_tkeep              (rx_axis_tkeep          ),
    .rx_axis_tvalid             (rx_axis_tvalid         ),
    .rx_axis_tlast              (rx_axis_tlast          ),
    .rx_axis_tready             (rx_axis_tready         ),
    .txp                        (txp                    ),
    .txn                        (txn                    ),
    .rxp                        (txp                    ),
    .rxn                        (txn                    )
    );

endmodule
