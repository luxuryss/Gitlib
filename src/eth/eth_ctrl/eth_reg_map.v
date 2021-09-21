`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/09/05 14:11:37
// Design Name: 
// Module Name: eth_reg_map
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
module eth_reg_map #(
    parameter                       REG_ADDR_WIDTH  = 32,
    parameter                       REG_DATA_WIDTH  = 32,
    parameter                       MDIO_REG_NUM    = 4 ,
    parameter                       MAC_REG_NUM     = 3
)(
    // >>>>>>>>>> sys
    input                           s_axi_aclk          ,
    input                           s_axi_aresetn       ,
    // >>>>>>>>>> cfg
    input                           cfg_wr_en           ,
    input   [REG_ADDR_WIDTH-1 : 0]  cfg_wr_addr         ,
    input   [REG_DATA_WIDTH-1 : 0]  cfg_wr_data         ,
    input                           cfg_rd_en           ,
    input   [REG_ADDR_WIDTH-1 : 0]  cfg_rd_addr         ,
    output                          cfg_rd_vld          ,
    output  [REG_DATA_WIDTH-1 : 0]  cfg_rd_data         ,
    // >>>>>>>>>> regs
    output  [MDIO_REG_NUM-1 : 0][REG_DATA_WIDTH-1 : 0]  mdio_cfg_regs   ,
    output  [MAC_REG_NUM-1 : 0][REG_DATA_WIDTH-1 : 0]   mac_cfg_regs
    );

// >>>>>>>>>> var
wire                                cfg_rd_vld_mdio, cfg_rd_vld_mac;
wire    [REG_DATA_WIDTH-1 : 0]      cfg_rd_data_mdio, cfg_rd_data_mac;
reg     [REG_DATA_WIDTH-1 : 0]      rdbk_reg;
wire                                rdbk_vld;

// >>>>>>>>>> reg_rdbk
assign rdbk_vld     = cfg_rd_vld_mdio | cfg_rd_vld_mac;
assign cfg_rd_data  = rdbk_reg;

sig_sync #(
    .DEPTH                  (1                  )
)
u_cfg_rd_vld (
    .clk                    (s_axi_aclk         ),
    .rstn                   (s_axi_aresetn      ),
    .sig_in                 (rdbk_vld           ),
    .sig_out_vld            (cfg_rd_vld         )
    );

always @(posedge s_axi_aclk or negedge s_axi_aresetn) begin
    if(s_axi_aresetn == 1'd0)
        rdbk_reg <= 'd0;
    else if(cfg_rd_en == 1'd1) begin
        case(cfg_rd_addr[11 : 8])
            4'h4: rdbk_reg <= (cfg_rd_vld_mac == 1'd1) ? cfg_rd_data_mac : rdbk_reg;
            4'h5: rdbk_reg <= (cfg_rd_vld_mdio == 1'd1) ? cfg_rd_data_mdio : rdbk_reg;
        endcase
    end
end

// >>>>>>>>>> mdio_regs
cfg_mdio_regs #(
    .REG_ADDR_WIDTH         (REG_ADDR_WIDTH     ),
    .REG_DATA_WIDTH         (REG_DATA_WIDTH     ),
    .MDIO_REG_NUM           (MDIO_REG_NUM       )
)
u_cfg_mdio_regs (
    .s_axi_aclk             (s_axi_aclk         ),
    .s_axi_aresetn          (s_axi_aresetn      ),
    .cfg_wr_en              (cfg_wr_en          ),
    .cfg_wr_addr            (cfg_wr_addr        ),
    .cfg_wr_data            (cfg_wr_data        ),
    .cfg_rd_en              (cfg_rd_en          ),
    .cfg_rd_addr            (cfg_rd_addr        ),
    .cfg_rd_vld             (cfg_rd_vld_mdio    ),
    .cfg_rd_data            (cfg_rd_data_mdio   ),
    .mdio_cfg_regs          (mdio_cfg_regs      )
    );

// >>>>>>>>>> mac_regs
cfg_mac_regs #(
    .REG_ADDR_WIDTH         (REG_ADDR_WIDTH     ),
    .REG_DATA_WIDTH         (REG_DATA_WIDTH     ),
    .MAC_REG_NUM            (MAC_REG_NUM        )
)
u_cfg_mac_regs (
    .s_axi_aclk             (s_axi_aclk         ),
    .s_axi_aresetn          (s_axi_aresetn      ),
    .cfg_wr_en              (cfg_wr_en          ),
    .cfg_wr_addr            (cfg_wr_addr        ),
    .cfg_wr_data            (cfg_wr_data        ),
    .cfg_rd_en              (cfg_rd_en          ),
    .cfg_rd_addr            (cfg_rd_addr        ),
    .cfg_rd_vld             (cfg_rd_vld_mac     ),
    .cfg_rd_data            (cfg_rd_data_mac    ),
    .mac_cfg_regs           (mac_cfg_regs       )
    );

endmodule
