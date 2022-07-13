`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/08/29 19:11:19
// Design Name: 
// Module Name: eth_wrap
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
module eth_wrap #(
    parameter                           S_AXI_ADDR_WIDTH    = 11,
    parameter                           S_AXI_DATA_WIDTH    = 32,
    parameter                           AXIS_DATA_WIDTH     = 64,
    parameter                           REG_ADDR_WIDTH      = 32,
    parameter                           REG_DATA_WIDTH      = 32
)(
    // >>>>>>>>>> clock & reset
    input                               refclk_p                ,
    input                               refclk_n                ,
    input                               rstn                    ,
    output                              coreclk                 ,
    input                               s_axi_aclk              ,    
    input                               s_axi_aresetn           ,
    input                               eth_en                  ,
    output                              eth_rst_done            ,
    output                              eth_init_done           ,
    // >>>>>>>>>> param
    input   [47 : 0]                    local_addr              ,
    input   [47 : 0]                    remote_addr             ,
    input   [15 : 0]                    tx_size                 ,
    input   [15 : 0]                    rx_size                 ,
    // >>>>>>>>>> usr_cfg
    input                               usr_cfg_type            ,
    input                               usr_wr_en               ,
    input   [REG_ADDR_WIDTH-1 : 0]      usr_wr_addr             ,
    input   [REG_DATA_WIDTH-1 : 0]      usr_wr_data             ,
    input                               usr_rd_en               ,
    input   [REG_ADDR_WIDTH-1 : 0]      usr_rd_addr             ,
    output                              usr_rd_vld              ,
    output  [REG_DATA_WIDTH-1 : 0]      usr_rd_data             ,
    // >>>>>>>>>> data
    input   [AXIS_DATA_WIDTH-1 : 0]     tx_axis_tdata           ,
    input   [AXIS_DATA_WIDTH/8-1 : 0]   tx_axis_tkeep           ,
    input                               tx_axis_tvalid          ,
    input                               tx_axis_tlast           ,
    output                              tx_axis_tready          ,
    output  [AXIS_DATA_WIDTH-1 : 0]     rx_axis_tdata           ,
    output  [AXIS_DATA_WIDTH/8-1 : 0]   rx_axis_tkeep           ,
    output                              rx_axis_tvalid          ,
    output                              rx_axis_tlast           ,
    input                               rx_axis_tready          ,
    // >>>>>>>>>> tx & rx
    output                              txp                     ,
    output                              txn                     ,
    input                               rxp                     ,
    input                               rxn
    );

// >>>>>>>>>> param
localparam                              FIFO_SIZE           = 1024;
localparam                              MDIO_REG_NUM        = 4;
localparam                              MAC_REG_NUM         = 3;

// >>>>>>>>>> var
wire                                    rxrecclk, qplllock_out, eth_cfg_start, resetdone_out;
wire    [7 : 0]                         pcspma_status;
wire    [25 : 0]                        tx_statistics_vector;
wire    [29 : 0]                        rx_statistics_vector;
wire                                    tx_statistics_valid;
wire                                    rx_statistics_valid;
wire                                    s_axi_awvalid, s_axi_awready, s_axi_wvalid, s_axi_wready, s_axi_bvalid, s_axi_bready, s_axi_arvalid, s_axi_arready, s_axi_rvalid, s_axi_rready;
wire    [S_AXI_ADDR_WIDTH-1 : 0]        s_axi_awaddr, s_axi_araddr;
wire    [S_AXI_DATA_WIDTH-1 : 0]        s_axi_wdata, s_axi_rdata;
wire    [1 : 0]                         s_axi_bresp, s_axi_rresp;
wire    [AXIS_DATA_WIDTH-1 : 0]         tx_frame_tdata, rx_frame_tdata;
wire    [AXIS_DATA_WIDTH/8-1 : 0]       tx_frame_tkeep, rx_frame_tkeep;
wire                                    tx_frame_tvalid, rx_frame_tvalid;
wire                                    tx_frame_tlast, rx_frame_tlast;
wire                                    tx_frame_tuser, rx_frame_tuser;
wire                                    tx_frame_tready, rx_frame_tready;
wire                                    sim_speedup_control;

// >>>>>>>>>> eth_cfg
eth_ctrl #(
    .S_AXI_ADDR_WIDTH           (S_AXI_ADDR_WIDTH           ),
    .S_AXI_DATA_WIDTH           (S_AXI_DATA_WIDTH           ),
    .REG_ADDR_WIDTH             (REG_ADDR_WIDTH             ),
    .REG_DATA_WIDTH             (REG_DATA_WIDTH             )
)
u_eth_ctrl (
    .s_axi_aclk                 (s_axi_aclk                 ),
    .s_axi_aresetn              (rstn                       ),
    .eth_en                     (eth_en                     ),
    .eth_rst_done               (eth_rst_done               ),
    .eth_init_done              (eth_init_done              ),
    .usr_cfg_type               (usr_cfg_type               ),
    .usr_wr_en                  (usr_wr_en                  ),
    .usr_wr_addr                (usr_wr_addr                ),
    .usr_wr_data                (usr_wr_data                ),
    .usr_rd_en                  (usr_rd_en                  ),
    .usr_rd_addr                (usr_rd_addr                ),
    .usr_rd_vld                 (usr_rd_vld                 ),
    .usr_rd_data                (usr_rd_data                ),
    .s_axi_awaddr               (s_axi_awaddr               ),
    .s_axi_awvalid              (s_axi_awvalid              ),
    .s_axi_awready              (s_axi_awready              ),
    .s_axi_wdata                (s_axi_wdata                ),
    .s_axi_wvalid               (s_axi_wvalid               ),
    .s_axi_wready               (s_axi_wready               ),
    .s_axi_bresp                (s_axi_bresp                ),
    .s_axi_bvalid               (s_axi_bvalid               ),
    .s_axi_bready               (s_axi_bready               ),
    .s_axi_araddr               (s_axi_araddr               ),
    .s_axi_arvalid              (s_axi_arvalid              ),
    .s_axi_arready              (s_axi_arready              ),
    .s_axi_rdata                (s_axi_rdata                ),
    .s_axi_rresp                (s_axi_rresp                ),
    .s_axi_rvalid               (s_axi_rvalid               ),
    .s_axi_rready               (s_axi_rready               ),
    .sim_speedup_control        (sim_speedup_control        )
    );

// >>>>>>>>>> eth_data
eth_frame_gen #(
    .AXIS_DATA_WIDTH            (AXIS_DATA_WIDTH            )
)
u_eth_frame_gen (
    .clk                        (coreclk                    ),
    .rstn                       (rstn                       ),
    .local_addr                 (local_addr                 ),
    .remote_addr                (remote_addr                ),
    .tx_size                    (tx_size                    ),
    .rx_size                    (rx_size                    ),
    .tx_orin_tdata              (tx_axis_tdata              ),
    .tx_orin_tkeep              (tx_axis_tkeep              ),
    .tx_orin_tvalid             (tx_axis_tvalid             ),
    .tx_orin_tlast              (tx_axis_tlast              ),
    .tx_orin_tuser              (tx_axis_tuser              ),
    .tx_orin_tready             (tx_axis_tready             ),
    .rx_orin_tdata              (rx_axis_tdata              ),
    .rx_orin_tkeep              (rx_axis_tkeep              ),
    .rx_orin_tvalid             (rx_axis_tvalid             ),
    .rx_orin_tlast              (rx_axis_tlast              ),
    .rx_orin_tuser              (rx_axis_tuser              ),
    .rx_orin_tready             (rx_axis_tready             ),
    .tx_frame_tdata             (tx_frame_tdata             ),
    .tx_frame_tkeep             (tx_frame_tkeep             ),
    .tx_frame_tvalid            (tx_frame_tvalid            ),
    .tx_frame_tlast             (tx_frame_tlast             ),
    .tx_frame_tuser             (tx_frame_tuser             ),
    .tx_frame_tready            (tx_frame_tready            ),
    .rx_frame_tdata             (rx_frame_tdata             ),
    .rx_frame_tkeep             (rx_frame_tkeep             ),
    .rx_frame_tvalid            (rx_frame_tvalid            ),
    .rx_frame_tlast             (rx_frame_tlast             ),
    .rx_frame_tuser             (rx_frame_tuser             ),
    .rx_frame_tready            (rx_frame_tready            )
    );

// >>>>>>>>>> eth_ip
axi_10g_ethernet_0_fifo_block #(
    .FIFO_SIZE                  (FIFO_SIZE                  )
)
fifo_block_i (
    .refclk_p                   (refclk_p                   ),
    .refclk_n                   (refclk_n                   ),
    .coreclk_out                (coreclk                    ),
    .rxrecclk_out               (rxrecclk                   ),
    .dclk                       (s_axi_aclk                 ),
    .reset                      (~rstn                      ),
    .tx_ifg_delay               (8'd0                       ),
    .tx_statistics_vector       (tx_statistics_vector       ),
    .tx_statistics_valid        (tx_statistics_valid        ),
    .rx_statistics_vector       (rx_statistics_vector       ),
    .rx_statistics_valid        (rx_statistics_valid        ),
    .pause_val                  (16'b0                      ),
    .pause_req                  (1'b0                       ),
    .rx_axis_fifo_aresetn       (rstn                       ),
    .rx_axis_mac_aresetn        (rstn                       ),
    .rx_axis_fifo_tdata         (rx_frame_tdata             ),
    .rx_axis_fifo_tkeep         (rx_frame_tkeep             ),
    .rx_axis_fifo_tvalid        (rx_frame_tvalid            ),
    .rx_axis_fifo_tlast         (rx_frame_tlast             ),
    .rx_axis_fifo_tready        (rx_frame_tready            ),
    .tx_axis_mac_aresetn        (rstn                       ),
    .tx_axis_fifo_aresetn       (rstn                       ),
    .tx_axis_fifo_tdata         (tx_frame_tdata             ),
    .tx_axis_fifo_tkeep         (tx_frame_tkeep             ),
    .tx_axis_fifo_tvalid        (tx_frame_tvalid            ),
    .tx_axis_fifo_tlast         (tx_frame_tlast             ),
    .tx_axis_fifo_tready        (tx_frame_tready            ),
    .s_axi_aclk                 (s_axi_aclk                 ),
    .s_axi_aresetn              (rstn                       ),
    .s_axi_awaddr               (s_axi_awaddr               ),
    .s_axi_awvalid              (s_axi_awvalid              ),
    .s_axi_awready              (s_axi_awready              ),
    .s_axi_wdata                (s_axi_wdata                ),
    .s_axi_wvalid               (s_axi_wvalid               ),
    .s_axi_wready               (s_axi_wready               ),
    .s_axi_bresp                (s_axi_bresp                ),
    .s_axi_bvalid               (s_axi_bvalid               ),
    .s_axi_bready               (s_axi_bready               ),
    .s_axi_araddr               (s_axi_araddr               ),
    .s_axi_arvalid              (s_axi_arvalid              ),
    .s_axi_arready              (s_axi_arready              ),
    .s_axi_rdata                (s_axi_rdata                ),
    .s_axi_rresp                (s_axi_rresp                ),
    .s_axi_rvalid               (s_axi_rvalid               ),
    .s_axi_rready               (s_axi_rready               ),
    .xgmacint                   (                           ),
    .txp                        (txp                        ),
    .txn                        (txn                        ),
    .rxp                        (rxp                        ),
    .rxn                        (rxn                        ),
    .signal_detect              (1'b1                       ),
    .tx_fault                   (1'b0                       ),
    .sim_speedup_control        (sim_speedup_control        ),
    .pcspma_status              (pcspma_status              ),
    .resetdone_out              (resetdone_out              ),
    .qplllock_out               (qplllock_out               )
);

endmodule
