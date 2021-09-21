`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/09/08 23:22:00
// Design Name: 
// Module Name: eth_ctrl
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
module eth_ctrl #(
    parameter                           S_AXI_ADDR_WIDTH    = 11,
    parameter                           S_AXI_DATA_WIDTH    = 32,
    parameter                           REG_ADDR_WIDTH      = 32,
    parameter                           REG_DATA_WIDTH      = 32
)(
    // >>>>>>>>>> sys
    input                               s_axi_aclk              ,
    input                               s_axi_aresetn           ,
    // >>>>>>>>>> usr_cfg
    input                               eth_en                  ,
    output                              eth_init_done           ,
    input                               usr_cfg_type            ,
    input                               usr_wr_en               ,
    input   [REG_ADDR_WIDTH-1 : 0]      usr_wr_addr             ,
    input   [REG_DATA_WIDTH-1 : 0]      usr_wr_data             ,
    input                               usr_rd_en               ,
    input   [REG_ADDR_WIDTH-1 : 0]      usr_rd_addr             ,
    output                              usr_rd_vld              ,
    output  [REG_DATA_WIDTH-1 : 0]      usr_rd_data             ,
    // >>>>>>>>>> axi_cfg
    output  [S_AXI_ADDR_WIDTH-1 : 0]    s_axi_awaddr            ,
    output                              s_axi_awvalid           ,
    input                               s_axi_awready           ,
    output  [S_AXI_DATA_WIDTH-1 : 0]    s_axi_wdata             ,
    output                              s_axi_wvalid            ,
    input                               s_axi_wready            ,
    input   [1 : 0]                     s_axi_bresp             ,
    input                               s_axi_bvalid            ,
    output                              s_axi_bready            ,
    output  [S_AXI_ADDR_WIDTH-1 : 0]    s_axi_araddr            ,
    output                              s_axi_arvalid           ,
    input                               s_axi_arready           ,
    input   [S_AXI_DATA_WIDTH-1 : 0]    s_axi_rdata             ,
    input   [1 : 0]                     s_axi_rresp             ,
    input                               s_axi_rvalid            ,
    output                              s_axi_rready            ,
    // >>>>>>>>>> status
    output                              sim_speedup_control
    );

// >>>>>>>>>> param
localparam                              S_AXI_CFG_GAP   = 7;

// >>>>>>>>>> var
wire                                    cfg_busy;
wire    [1 : 0]                         cfg_resp;
wire                                    cfg_wr_en;
wire    [REG_ADDR_WIDTH-1 : 0]          cfg_wr_addr;
wire    [REG_DATA_WIDTH-1 : 0]          cfg_wr_data;
wire                                    cfg_rd_en;
wire    [REG_ADDR_WIDTH-1 : 0]          cfg_rd_addr;
wire                                    cfg_rd_vld;
wire    [REG_DATA_WIDTH-1 : 0]          cfg_rd_data;

// >>>>>>>>>> eth_ctrl
eth_fsm #(
    .REG_ADDR_WIDTH         (REG_ADDR_WIDTH         ),
    .REG_DATA_WIDTH         (REG_DATA_WIDTH         ) 
)
u_eth_fsm (
    .clk                    (s_axi_aclk             ),
    .rstn                   (s_axi_aresetn          ),
    .eth_en                 (eth_en                 ),
    .eth_init_done          (eth_init_done          ),
    .usr_cfg_type           (usr_cfg_type           ),
    .usr_wr_en              (usr_wr_en              ),
    .usr_wr_addr            (usr_wr_addr            ),
    .usr_wr_data            (usr_wr_data            ),
    .usr_rd_en              (usr_rd_en              ),
    .usr_rd_addr            (usr_rd_addr            ),
    .usr_rd_vld             (usr_rd_vld             ),
    .usr_rd_data            (usr_rd_data            ),    
    .cfg_busy               (cfg_busy               ),
    .cfg_resp               (cfg_resp               ),
    .cfg_wr_en              (cfg_wr_en              ),
    .cfg_wr_addr            (cfg_wr_addr            ),
    .cfg_wr_data            (cfg_wr_data            ),
    .cfg_rd_en              (cfg_rd_en              ),
    .cfg_rd_addr            (cfg_rd_addr            ),
    .cfg_rd_vld             (cfg_rd_vld             ),
    .cfg_rd_data            (cfg_rd_data            ),
    .sim_speedup_control    (sim_speedup_control    )
    );

// >>>>>>>>>> eth_cfg
eth_cfg #(
    .S_AXI_ADDR_WIDTH       (S_AXI_ADDR_WIDTH       ),
    .S_AXI_DATA_WIDTH       (S_AXI_DATA_WIDTH       ),
    .REG_ADDR_WIDTH         (REG_ADDR_WIDTH         ),
    .REG_DATA_WIDTH         (REG_DATA_WIDTH         ),
    .S_AXI_CFG_GAP          (S_AXI_CFG_GAP          )
)
u_eth_cfg(
    .s_axi_aclk             (s_axi_aclk             ),
    .s_axi_aresetn          (s_axi_aresetn          ),
    .cfg_busy               (cfg_busy               ),
    .cfg_resp               (cfg_resp               ),
    .cfg_wr_en              (cfg_wr_en              ),
    .cfg_wr_addr            (cfg_wr_addr            ),
    .cfg_wr_data            (cfg_wr_data            ),
    .cfg_rd_en              (cfg_rd_en              ),
    .cfg_rd_addr            (cfg_rd_addr            ),
    .cfg_rd_vld             (cfg_rd_vld             ),
    .cfg_rd_data            (cfg_rd_data            ),
    .s_axi_awaddr           (s_axi_awaddr           ),
    .s_axi_awvalid          (s_axi_awvalid          ),
    .s_axi_awready          (s_axi_awready          ),
    .s_axi_wdata            (s_axi_wdata            ),
    .s_axi_wvalid           (s_axi_wvalid           ),
    .s_axi_wready           (s_axi_wready           ),
    .s_axi_bresp            (s_axi_bresp            ),
    .s_axi_bvalid           (s_axi_bvalid           ),
    .s_axi_bready           (s_axi_bready           ),
    .s_axi_araddr           (s_axi_araddr           ),
    .s_axi_arvalid          (s_axi_arvalid          ),
    .s_axi_arready          (s_axi_arready          ),
    .s_axi_rdata            (s_axi_rdata            ),
    .s_axi_rresp            (s_axi_rresp            ),
    .s_axi_rvalid           (s_axi_rvalid           ),
    .s_axi_rready           (s_axi_rready           )
    );

endmodule
