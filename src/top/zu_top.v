`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/04/23 16:47:58
// Design Name: 
// Module Name: zu_top
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
module zu_top ();

// >>>>>>>>>> param
// bd
localparam                           MM2S_DATA_WIDTH = 64;
localparam                           S2MM_DATA_WIDTH = 64;
localparam                           MM2S_CMD_WIDTH  = 72;
localparam                           S2MM_CMD_WIDTH  = 72;
localparam                           MM2S_STS_WIDTH  = 8;
localparam                           S2MM_STS_WIDTH  = 32;
localparam                           ADDR_WIDTH      = 32;
localparam                           LEN_WIDTH       = 16;

// >>>>>>>>>> var
// clk_rst
wire                                 ps_clk_100m, ps_clk_125m, ps_clk_250m, ps_clk_300m, ps_rstn;
wire                                 clk_100m, clk_125m, clk_250m, clk_300m, rstn;

// >>>>>>>>>> clk_rst
clk_rst_gen u_clk_rst_gen (
    .ps_clk_100m        (ps_clk_100m            ),
    .ps_clk_125m        (ps_clk_125m            ),
    .ps_clk_250m        (ps_clk_250m            ),
    .ps_clk_300m        (ps_clk_300m            ),
    .ps_rstn            (ps_rstn                ),
    .pl_clk_100m        (clk_100m               ),
    .pl_clk_125m        (clk_125m               ),
    .pl_clk_250m        (clk_250m               ),
    .pl_clk_300m        (clk_300m               ),
    .pl_rstn_100m       (                       ),
    .pl_rstn_125m       (                       ),
    .pl_rstn_250m       (rstn_250m              ),
    .pl_rstn_300m       (                       )
    );

// >>>>>>>>>> sys_cfg_wrap
sys_cfg_wrap #(
    .ADDR_WIDTH         (ADDR_WIDTH             ),
    .DATA_WIDTH         (DATA_WIDTH             ),
    .BYTE_NUM           (BYTE_NUM               )
)
u_sys_cfg_wrap (
    .clk                (clk_250m               ),
    .rstn               (rstn                   ),
    .bram_en            (bram_en                ),
    .bram_we            (bram_we                ),
    .bram_addr          (bram_addr              ),
    .bram_din           (bram_din               ),
    .bram_dout          (bram_dout              ),
    .reg_0              (reg_0                  ),
    .reg_1              (reg_1                  ),
    .reg_2              (reg_2                  ),
    .reg_3              (reg_3                  )
    );

// >>>>>>>>>> block_design
bd_wrap #(
    .MM2S_DATA_WIDTH    (MM2S_DATA_WIDTH        ),
    .S2MM_DATA_WIDTH    (S2MM_DATA_WIDTH        ),
    .MM2S_CMD_WIDTH     (MM2S_CMD_WIDTH         ),
    .S2MM_CMD_WIDTH     (S2MM_CMD_WIDTH         ),
    .MM2S_STS_WIDTH     (MM2S_STS_WIDTH         ),
    .S2MM_STS_WIDTH     (S2MM_STS_WIDTH         ),
    .ADDR_WIDTH         (ADDR_WIDTH             ),
    .LEN_WIDTH          (LEN_WIDTH              )
)
u_bd_wrap (
    .ps_clk_100m        (ps_clk_100m            ),
    .ps_clk_125m        (ps_clk_125m            ),
    .ps_clk_250m        (ps_clk_250m            ),
    .ps_clk_300m        (ps_clk_300m            ),
    .ps_rstn            (ps_rstn                ),
    .wstart             (wstart                 ),
    .wready             (wready                 ),
    .waddr              (waddr                  ),
    .wdata_len          (wdata_len              ),
    .wdata_vld          (wdata_vld              ),
    .wdata              (wdata                  ),
    .rstart             (rstart                 ),
    .rready             (rready                 ),
    .raddr              (raddr                  ),
    .rdata_len          (rdata_len              ),
    .rdata_vld          (rdata_vld              ),
    .rdata              (rdata                  )
    );

endmodule
