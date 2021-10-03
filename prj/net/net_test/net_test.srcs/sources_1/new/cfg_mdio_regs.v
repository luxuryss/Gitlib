`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/09/05 14:54:39
// Design Name: 
// Module Name: cfg_mdio_regs
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
module cfg_mdio_regs #(
    parameter                       REG_ADDR_WIDTH  = 32,
    parameter                       REG_DATA_WIDTH  = 32,
    parameter                       MDIO_REG_NUM    = 4
)(
    input                           s_axi_aclk          ,
    input                           s_axi_aresetn       ,
    input                           cfg_wr_en           ,
    input   [REG_ADDR_WIDTH-1 : 0]  cfg_wr_addr         ,
    input   [REG_DATA_WIDTH-1 : 0]  cfg_wr_data         ,
    input                           cfg_rd_en           ,
    input   [REG_ADDR_WIDTH-1 : 0]  cfg_rd_addr         ,
    output                          cfg_rd_vld          ,
    output  [REG_DATA_WIDTH-1 : 0]  cfg_rd_data         ,
    output  [MDIO_REG_NUM-1 : 0][REG_DATA_WIDTH-1 : 0]  mdio_cfg_regs
    );

// >>>>>>>>>> reg_addr
localparam                  MDIO_CFG_WORD_0     = 32'h500;
localparam                  MDIO_CFG_WORD_1     = 32'h504;
localparam                  MDIO_TX_DATA        = 32'h508;
localparam                  MDIO_RX_DATA        = 32'h50C;

// >>>>>>>>>> var
reg     [REG_DATA_WIDTH-1 : 0]  rdbk_reg;

// >>>>>>>>>> reg_rdbk
assign cfg_rd_data = rdbk_reg;

sig_sync #(
    .DEPTH                  (1                      )
)
u_cfg_rd_vld (
    .clk                    (s_axi_aclk             ),
    .rstn                   (s_axi_aresetn          ),
    .sig_in                 (cfg_rd_en              ),
    .sig_out_vld            (cfg_rd_vld             )
    );

always @(posedge s_axi_aclk or negedge s_axi_aresetn) begin
    if(s_axi_aresetn == 1'd0)
        rdbk_reg <= 'd0;
    else if(cfg_rd_en == 1'd1) begin
        case(cfg_rd_addr)
            MDIO_CFG_WORD_0:
                rdbk_reg <= mdio_cfg_regs[0];
            MDIO_CFG_WORD_1:
                rdbk_reg <= mdio_cfg_regs[1];
            MDIO_TX_DATA:
                rdbk_reg <= mdio_cfg_regs[2];
            MDIO_RX_DATA:
                rdbk_reg <= mdio_cfg_regs[2];
            default:
                rdbk_reg <= 'd0;
        endcase
    end
end

// >>>>>>>>>> reg_cfg
cfg_reg #(
    .INIT_VALUE             (32'b0000_0000_0000_0000_0000_0000_0100_0101                ),
    .REG_ADDR_WIDTH         (REG_ADDR_WIDTH         ),
    .REG_DATA_WIDTH         (REG_DATA_WIDTH         )
)
u_mdio_cfg_word_0 (
    .clk                    (s_axi_aclk             ),
    .rstn                   (s_axi_aresetn          ),
    .cfg_vld                ((cfg_wr_en == 1'd1) && (cfg_wr_addr == MDIO_CFG_WORD_0)    ),
    .cfg_data               (cfg_wr_data            ),
    .reg_data               (mdio_cfg_regs[0] )
    );

cfg_reg #(
    .INIT_VALUE             (32'b0000_0000_0000_0011_0000_1000_0000_0000                ),
    .REG_ADDR_WIDTH         (REG_ADDR_WIDTH         ),
    .REG_DATA_WIDTH         (REG_DATA_WIDTH         )
)
u_mdio_cfg_word_1 (
    .clk                    (s_axi_aclk             ),
    .rstn                   (s_axi_aresetn          ),
    .cfg_vld                ((cfg_wr_en == 1'd1) && (cfg_wr_addr == MDIO_CFG_WORD_1)    ),
    .cfg_data               (cfg_wr_data            ),
    .reg_data               (mdio_cfg_regs[1] )
    );

cfg_reg #(
    .INIT_VALUE             (32'b1001_0000_0000_0000_0000_0000_0000_0000                ),
    .REG_ADDR_WIDTH         (REG_ADDR_WIDTH         ),
    .REG_DATA_WIDTH         (REG_DATA_WIDTH         )
)
u_mdio_tx_data (
    .clk                    (s_axi_aclk             ),
    .rstn                   (s_axi_aresetn          ),
    .cfg_vld                ((cfg_wr_en == 1'd1) && (cfg_wr_addr == MDIO_TX_DATA)       ),
    .cfg_data               (cfg_wr_data            ),
    .reg_data               (mdio_cfg_regs[2] )
    );

cfg_reg #(
    .INIT_VALUE             (32'b0000_0000_0000_0000_0000_0000_0000_0000                ),
    .REG_ADDR_WIDTH         (REG_ADDR_WIDTH         ),
    .REG_DATA_WIDTH         (REG_DATA_WIDTH         )
)
u_mdio_rx_data (
    .clk                    (s_axi_aclk             ),
    .rstn                   (s_axi_aresetn          ),
    .cfg_vld                ((cfg_wr_en == 1'd1) && (cfg_wr_addr == MDIO_RX_DATA)       ),
    .cfg_data               (cfg_wr_data            ),
    .reg_data               (mdio_cfg_regs[3] )
    );

endmodule
