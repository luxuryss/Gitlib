`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/08/30 23:07:36
// Design Name: 
// Module Name: test_top
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
module test_top();

// >>>>>>>>>> param
localparam                      S_AXI_ADDR_WIDTH    = 11;
localparam                      S_AXI_DATA_WIDTH    = 32;
localparam                      AXIS_DATA_WIDTH     = 64;
localparam                      REG_ADDR_WIDTH      = 32;
localparam                      REG_DATA_WIDTH      = 32;

// >>>>>>>>>> define
wire                            clk_156p25m, clk_100m, clk_125m, clk_200m, clk_250m, coreclk, sys_rstn;
wire                            txp, txn, rxp, rxn;

// >>>>>>>>>> en
initial begin
    force test_top.u_top.test_tx_data_en    = 1'd0;
    #45us;
    force test_top.u_top.test_cfg_type      = 1'd0;
    force test_top.u_top.test_cfg_wr_en     = 1'd1;
    force test_top.u_top.test_cfg_wr_addr   = 'hffff;
    force test_top.u_top.test_cfg_wr_data   = 'hab4a;
    #10ns;
    force test_top.u_top.test_cfg_wr_en     = 1'd0;
    #15us;
    force test_top.u_top.test_cfg_rd_en     = 1'd1;
    force test_top.u_top.test_cfg_rd_addr   = 'hffff;
    #10ns;
    force test_top.u_top.test_cfg_rd_en     = 1'd0;    
    #15us;
    force test_top.u_top.test_cfg_type      = 1'd1;
    force test_top.u_top.test_cfg_wr_en     = 1'd1;
    force test_top.u_top.test_cfg_wr_addr   = 'h41C;
    force test_top.u_top.test_cfg_wr_data   = 'habcd0000;
    #10ns;
    force test_top.u_top.test_cfg_wr_en     = 1'd0;
    #2us;
    force test_top.u_top.test_cfg_rd_en     = 1'd1;
    force test_top.u_top.test_cfg_rd_addr   = 'h41C;
    #10ns;
    force test_top.u_top.test_cfg_rd_en     = 1'd0;
    #1us;
    force test_top.u_top.test_tx_data_en    = 1'd1;
end

// >>>>>>>>>> clock & reset
sim_clk_rst u_sim_clk_rst (
    .clk_156p25m                (clk_156p25m                ),
    .clk_100m                   (clk_100m                   ),
    .clk_125m                   (clk_125m                   ),
    .clk_200m                   (clk_200m                   ),
    .clk_250m                   (clk_250m                   ),
    .rstn                       (sys_rstn                   )
    );

// >>>>>>>>>> eth_wrap
top #(
    .S_AXI_ADDR_WIDTH           (S_AXI_ADDR_WIDTH           ),
    .S_AXI_DATA_WIDTH           (S_AXI_DATA_WIDTH           ),
    .AXIS_DATA_WIDTH            (AXIS_DATA_WIDTH            ),
    .REG_ADDR_WIDTH             (REG_ADDR_WIDTH             ),
    .REG_DATA_WIDTH             (REG_DATA_WIDTH             )
)
u_top (
    .clk_156p25m_p              (clk_156p25m                ),
    .clk_156p25m_n              (~clk_156p25m               ),
    .clk_100m                   (clk_100m                   ),
    .txp                        (txp                        ),
    .txn                        (txn                        ),
    .rxp                        (txp                        ),
    .rxn                        (txn                        )
    );

endmodule
