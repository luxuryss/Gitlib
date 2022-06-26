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
module zu_top (

);

// >>>>>>>>>> param
// bd
localparam                          CFG_ADDR_WIDTH  = 32;
localparam                          CFG_DATA_WIDTH  = 32;
localparam                          S2MM_DATA_WIDTH = 64;
localparam                          S2MM_CMD_WIDTH  = 72;
localparam                          S2MM_ADDR_WIDTH = 32;
localparam                          S2MM_SIZE_WIDTH = 16;
localparam                          S2MM_STS_WIDTH  = 32;
localparam                          MM2S_DATA_WIDTH = 64;
localparam                          MM2S_CMD_WIDTH  = 72;
localparam                          MM2S_ADDR_WIDTH = 32;
localparam                          MM2S_SIZE_WIDTH = 16;
localparam                          MM2S_STS_WIDTH  = 8;

// >>>>>>>>>> var
// clk_rst
wire                                ps_clk_100m, ps_clk_125m, ps_clk_250m, ps_clk_300m, ps_rstn;
wire                                clk_100m, clk_125m, clk_250m, clk_300m, rstn;
// cfg
wire    [CFG_ADDR_WIDTH-1:0]        bram_cfg_addr;
wire    [CFG_DATA_WIDTH-1:0]        bram_cfg_data;
wire    [CFG_DATA_WIDTH-1:0]        bram_cfg_rdbk;
wire                                bram_cfg_en;
wire    [CFG_DATA_WIDTH/8-1:0]      bram_cfg_we;
// ddr_ctrl
wire                                ddr_wreq_ready;
wire                                ddr_wreq_valid;
wire    [S2MM_ADDR_WIDTH-1:0]       ddr_wreq_addr;
wire    [S2MM_SIZE_WIDTH-1:0]       ddr_wreq_size;
wire                                ddr_wdata_ready;
wire                                ddr_wdata_valid;
wire                                ddr_wdata_last;
wire    [S2MM_DATA_WIDTH-1:0]       ddr_wdata;
wire                                ddr_wresp_valid;
wire    [1:0]                       ddr_wresp;
wire                                ddr_rreq_ready;
wire                                ddr_rreq_valid;
wire    [MM2S_ADDR_WIDTH-1:0]       ddr_rreq_addr;
wire    [MM2S_SIZE_WIDTH-1:0]       ddr_rreq_size;
wire                                ddr_rdata_ready;
wire                                ddr_rdata_valid;
wire                                ddr_rdata_last;
wire    [MM2S_DATA_WIDTH-1:0]       ddr_rdata;
wire                                ddr_rresp_valid;
wire    [1:0]                       ddr_rresp;
// vio
wire                                test_en;
wire    [CFG_ADDR_WIDTH-1:0]        test_addr;
wire    [15:0]                      test_size;
wire    [7:0]                       test_err_cnt;

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
    .pl_rstn            (rstn                   )
    );

// >>>>>>>>>> sys_cfg_wrap
sys_cfg_wrap #(
    .ADDR_WIDTH         (CFG_ADDR_WIDTH         ),
    .DATA_WIDTH         (CFG_DATA_WIDTH         )
)
u_sys_cfg_wrap (
    .clk                (clk_250m               ),
    .rstn               (rstn                   ),
    .bram_cfg_en        (bram_cfg_en            ),
    .bram_cfg_we        (bram_cfg_we            ),
    .bram_cfg_addr      (bram_cfg_addr          ),
    .bram_cfg_data      (bram_cfg_data          ),
    .bram_cfg_rdbk      (bram_cfg_rdbk          ),
    .reg_0              (reg_0                  ),
    .reg_1              (reg_1                  ),
    .reg_2              (reg_2                  ),
    .reg_3              (reg_3                  )
    );

vio_cfg u_vio_cfg (
    .clk                (ps_clk_250m            ),
    .probe_in0          (test_err_cnt           ),
    .probe_out0         (test_en                ),
    .probe_out1         (test_addr              ),
    .probe_out2         (test_size              )
);

// >>>>>>>>>> test_data
test_data_gen #(
    .CFG_ADDR_WIDTH     (CFG_ADDR_WIDTH         ),
    .CFG_DATA_WIDTH     (CFG_DATA_WIDTH         ),
    .S2MM_DATA_WIDTH    (S2MM_DATA_WIDTH        ),
    .S2MM_CMD_WIDTH     (S2MM_CMD_WIDTH         ),
    .S2MM_ADDR_WIDTH    (S2MM_ADDR_WIDTH        ),
    .S2MM_SIZE_WIDTH    (S2MM_SIZE_WIDTH        ),
    .S2MM_STS_WIDTH     (S2MM_STS_WIDTH         ),
    .MM2S_DATA_WIDTH    (MM2S_DATA_WIDTH        ),
    .MM2S_CMD_WIDTH     (MM2S_CMD_WIDTH         ),
    .MM2S_ADDR_WIDTH    (MM2S_ADDR_WIDTH        ),
    .MM2S_SIZE_WIDTH    (MM2S_SIZE_WIDTH        ),
    .MM2S_STS_WIDTH     (MM2S_STS_WIDTH         )
)
u_test_data (
    .clk                (clk                    ),
    .rstn               (rstn                   ),
    .test_en            (test_en                ),
    .test_addr          (test_addr              ),
    .test_size          (test_size              ),
    .test_err_cnt       (test_err_cnt           ),
    .wreq_ready         (ddr_wreq_ready         ),
    .wreq_valid         (ddr_wreq_valid         ),
    .wreq_addr          (ddr_wreq_addr          ),
    .wreq_size          (ddr_wreq_size          ),
    .wdata_ready        (ddr_wdata_ready        ),
    .wdata_valid        (ddr_wdata_valid        ),
    .wdata_last         (ddr_wdata_last         ),
    .wdata              (ddr_wdata              ),
    .wresp_valid        (ddr_wresp_valid        ),
    .wresp              (ddr_wresp              ),
    .rreq_ready         (ddr_rreq_ready         ),
    .rreq_valid         (ddr_rreq_valid         ),
    .rreq_addr          (ddr_rreq_addr          ),
    .rreq_size          (ddr_rreq_size          ),
    .rdata_ready        (ddr_rdata_ready        ),
    .rdata_valid        (ddr_rdata_valid        ),
    .rdata_last         (ddr_rdata_last         ),
    .rdata              (ddr_rdata              ),
    .rresp_valid        (ddr_rresp_valid        ),
    .rresp              (ddr_rresp              )
    );

// >>>>>>>>>> block_design
bd_wrap #(
    .CFG_ADDR_WIDTH     (CFG_ADDR_WIDTH         ),
    .CFG_DATA_WIDTH     (CFG_DATA_WIDTH         ),
    .S2MM_DATA_WIDTH    (S2MM_DATA_WIDTH        ),
    .S2MM_CMD_WIDTH     (S2MM_CMD_WIDTH         ),
    .S2MM_ADDR_WIDTH    (S2MM_ADDR_WIDTH        ),
    .S2MM_SIZE_WIDTH    (S2MM_SIZE_WIDTH        ),
    .S2MM_STS_WIDTH     (S2MM_STS_WIDTH         ),
    .MM2S_DATA_WIDTH    (MM2S_DATA_WIDTH        ),
    .MM2S_CMD_WIDTH     (MM2S_CMD_WIDTH         ),
    .MM2S_ADDR_WIDTH    (MM2S_ADDR_WIDTH        ),
    .MM2S_SIZE_WIDTH    (MM2S_SIZE_WIDTH        ),
    .MM2S_STS_WIDTH     (MM2S_STS_WIDTH         )
)
u_bd_wrap (
    .ps_clk_100m        (ps_clk_100m            ),
    .ps_clk_125m        (ps_clk_125m            ),
    .ps_clk_250m        (ps_clk_250m            ),
    .ps_clk_300m        (ps_clk_300m            ),
    .ps_rstn            (ps_rstn                ),
    .bram_cfg_addr      (bram_cfg_addr          ),
    .bram_cfg_data      (bram_cfg_data          ),
    .bram_cfg_rdbk      (bram_cfg_rdbk          ),
    .bram_cfg_en        (bram_cfg_en            ),
    .bram_cfg_we        (bram_cfg_we            ),
    .ddr_wreq_ready     (ddr_wreq_ready         ),
    .ddr_wreq_valid     (ddr_wreq_valid         ),
    .ddr_wreq_addr      (ddr_wreq_addr          ),
    .ddr_wreq_size      (ddr_wreq_size          ),
    .ddr_wdata_ready    (ddr_wdata_ready        ),
    .ddr_wdata_valid    (ddr_wdata_valid        ),
    .ddr_wdata_last     (ddr_wdata_last         ),
    .ddr_wdata          (ddr_wdata              ),
    .ddr_wresp_valid    (ddr_wresp_valid        ),
    .ddr_wresp          (ddr_wresp              ),
    .ddr_rreq_ready     (ddr_rreq_ready         ),
    .ddr_rreq_valid     (ddr_rreq_valid         ),
    .ddr_rreq_addr      (ddr_rreq_addr          ),
    .ddr_rreq_size      (ddr_rreq_size          ),
    .ddr_rdata_ready    (ddr_rdata_ready        ),
    .ddr_rdata_valid    (ddr_rdata_valid        ),
    .ddr_rdata_last     (ddr_rdata_last         ),
    .ddr_rdata          (ddr_rdata              ),
    .ddr_rresp_valid    (ddr_rresp_valid        ),
    .ddr_rresp          (ddr_rresp              )
    );

endmodule
