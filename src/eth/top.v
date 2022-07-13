`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/09/15 13:45:42
// Design Name: 
// Module Name: top
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
module top #(
    parameter                           S_AXI_ADDR_WIDTH    = 11,
    parameter                           S_AXI_DATA_WIDTH    = 32,
    parameter                           AXIS_DATA_WIDTH     = 64,
    parameter                           REG_ADDR_WIDTH      = 32,
    parameter                           REG_DATA_WIDTH      = 32
)(
    // clock & reset
    input                               clk_156p25m_p           ,
    input                               clk_156p25m_n           ,
    input                               clk_125m                ,
    // tx & rx
    output                              txp                     ,
    output                              txn                     ,
    input                               rxp                     ,
    input                               rxn
    );

// >>>>>>>>>> var
wire                            coreclk, rstn;
wire                            eth_en, eth_init_done, usr_cfg_type, usr_wr_en, usr_rd_en, usr_rd_vld;
wire [REG_ADDR_WIDTH-1 : 0]     usr_wr_addr, usr_rd_addr;
wire [REG_DATA_WIDTH-1 : 0]     usr_wr_data, usr_rd_data;
wire [AXIS_DATA_WIDTH-1 : 0]    tx_axis_tdata, rx_axis_tdata;
wire [AXIS_DATA_WIDTH/8-1 : 0]  tx_axis_tkeep, rx_axis_tkeep;
wire                            tx_axis_tvalid, tx_axis_tlast, tx_axis_tready, rx_axis_tvalid, rx_axis_tlast, rx_axis_tready;
wire                            test_tx_data_en, test_cfg_type, test_cfg_wr_en, test_cfg_rd_en;
wire [REG_ADDR_WIDTH-1 : 0]     test_cfg_wr_addr, test_cfg_rd_addr;
wire [REG_DATA_WIDTH-1 : 0]     test_cfg_wr_data, test_cfg_rd_data;

// >>>>>>>>>> clk_rst
/* clk_wiz_0 u_clk_wiz_0 (
    .clk_out1                   (clk_125m                   ),
    .reset                      (1'd0                       ),
    .locked                     (rstn                       ),
    .clk_in1                    (clk_100m                   )
    );*/

// >>>>>>>>>> vio_ctrl
vio_cfg u_vio_cfg (
    .clk                        (clk_125m                   ),
    .probe_in0                  (test_cfg_rd_data           ),
    .probe_out0                 (test_tx_data_en            ),
    .probe_out1                 (test_cfg_type              ),
    .probe_out2                 (test_cfg_wr_en             ),
    .probe_out3                 (test_cfg_wr_addr           ),
    .probe_out4                 (test_cfg_wr_data           ),
    .probe_out5                 (test_cfg_rd_en             ),
    .probe_out6                 (test_cfg_rd_addr           )
    );

// >>>>>>>>>> eth_test_ctrl
test_cfg #(
    .REG_ADDR_WIDTH             (REG_ADDR_WIDTH             ),
    .REG_DATA_WIDTH             (REG_DATA_WIDTH             )
)
u_test_cfg (
    .clk                        (clk_125m                   ),
    .rstn                       (rstn                       ),
    .eth_en                     (eth_en                     ),
    .eth_init_done              (eth_init_done              ),
    .test_cfg_type              (test_cfg_type              ),
    .test_cfg_wr_en             (test_cfg_wr_en             ),
    .test_cfg_wr_addr           (test_cfg_wr_addr           ),
    .test_cfg_wr_data           (test_cfg_wr_data           ),
    .test_cfg_rd_en             (test_cfg_rd_en             ),
    .test_cfg_rd_addr           (test_cfg_rd_addr           ),
    .test_cfg_rd_data           (test_cfg_rd_data           ),
    .usr_cfg_type               (usr_cfg_type               ),
    .usr_wr_en                  (usr_wr_en                  ),
    .usr_wr_addr                (usr_wr_addr                ),
    .usr_wr_data                (usr_wr_data                ),
    .usr_rd_en                  (usr_rd_en                  ),
    .usr_rd_addr                (usr_rd_addr                ),
    .usr_rd_vld                 (usr_rd_vld                 ),
    .usr_rd_data                (usr_rd_data                )
    );

// >>>>>>>>>> eth_test_data
test_axis_data_gen #(
    .AXIS_DATA_WIDTH            (AXIS_DATA_WIDTH            )
)
u_test_axis_data_gen (
    .clk                        (coreclk                    ),
    .rstn                       (rstn                       ),
    .test_en                    (test_tx_data_en            ),
    .tx_axis_tdata              (tx_axis_tdata              ),
    .tx_axis_tkeep              (tx_axis_tkeep              ),
    .tx_axis_tvalid             (tx_axis_tvalid             ),
    .tx_axis_tlast              (tx_axis_tlast              ),
    .tx_axis_tready             (tx_axis_tready             ),
    .rx_axis_tdata              (rx_axis_tdata              ),
    .rx_axis_tkeep              (rx_axis_tkeep              ),
    .rx_axis_tvalid             (rx_axis_tvalid             ),
    .rx_axis_tlast              (rx_axis_tlast              ),
    .rx_axis_tready             (rx_axis_tready             )
    );

// >>>>>>>>>> eth_wrap
eth_wrap #(
    .S_AXI_ADDR_WIDTH           (S_AXI_ADDR_WIDTH           ),
    .S_AXI_DATA_WIDTH           (S_AXI_DATA_WIDTH           ),
    .AXIS_DATA_WIDTH            (AXIS_DATA_WIDTH            ),
    .REG_ADDR_WIDTH             (REG_ADDR_WIDTH             ),
    .REG_DATA_WIDTH             (REG_DATA_WIDTH             )
)
u_eth_wrap (
    .refclk_p                   (clk_156p25m_p              ),
    .refclk_n                   (clk_156p25m_n              ),
    .rstn                       (rstn                       ),
    .coreclk                    (coreclk                    ),
    .s_axi_aclk                 (clk_125m                   ),
    .s_axi_aresetn              (rstn                       ),
    .eth_en                     (eth_en                     ),
    .eth_init_done              (eth_init_done              ),
    .usr_cfg_type               (usr_cfg_type               ),
    .usr_wr_en                  (usr_wr_en                  ),
    .usr_wr_addr                (usr_wr_addr                ),
    .usr_wr_data                (usr_wr_data                ),
    .usr_rd_en                  (usr_rd_en                  ),
    .usr_rd_addr                (usr_rd_addr                ),
    .usr_rd_vld                 (usr_rd_vld                 ),
    .usr_rd_data                (usr_rd_data                ),
    .tx_axis_tdata              (tx_axis_tdata              ),
    .tx_axis_tkeep              (tx_axis_tkeep              ),
    .tx_axis_tvalid             (tx_axis_tvalid             ),
    .tx_axis_tlast              (tx_axis_tlast              ),
    .tx_axis_tready             (tx_axis_tready             ),
    .rx_axis_tdata              (rx_axis_tdata              ),
    .rx_axis_tkeep              (rx_axis_tkeep              ),
    .rx_axis_tvalid             (rx_axis_tvalid             ),
    .rx_axis_tlast              (rx_axis_tlast              ),
    .rx_axis_tready             (rx_axis_tready             ),
    .txp                        (txp                        ),
    .txn                        (txn                        ),
    .rxp                        (txp                        ),
    .rxn                        (txn                        )
    );

endmodule
