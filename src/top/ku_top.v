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
    input                               clk                 ,
    input                               rstn                ,
    // >>>>>>>>>> ddr
    input                               ddr4_clk_p          ,
    input                               ddr4_clk_n          ,
    output                              ddr4_init_done      ,
    output                              ddr4_rtl_act_n      ,
    output                              ddr4_rtl_adr        ,
    output                              ddr4_rtl_ba         ,
    output                              ddr4_rtl_bg         ,
    output                              ddr4_rtl_ck_c       ,
    output                              ddr4_rtl_ck_t       ,
    output                              ddr4_rtl_cke        ,
    output                              ddr4_rtl_cs_n       ,
    inout                               ddr4_rtl_dm_n       ,
    inout                               ddr4_rtl_dq         ,
    inout                               ddr4_rtl_dqs_c      ,
    inout                               ddr4_rtl_dqs_t      ,
    output                              ddr4_rtl_odt
    );

// >>>>>>>>>> param
// ddr4
localparam                              MM2S_DATA_WIDTH = 64;
localparam                              S2MM_DATA_WIDTH = 64;
localparam                              MM2S_CMD_WIDTH  = 72;
localparam                              S2MM_CMD_WIDTH  = 72;
localparam                              MM2S_STS_WIDTH  = 8 ;
localparam                              S2MM_STS_WIDTH  = 32;
localparam                              ADDR_WIDTH      = 32;
localparam                              LEN_WIDTH       = 16;

// >>>>>>>>>> var
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

// >>>>>>>>>> test_data_gen
test_data_gen #(
    .WDATA_WIDTH                (S2MM_DATA_WIDTH        ),
    .RDATA_WIDTH                (MM2S_DATA_WIDTH        ),
    .ADDR_WIDTH                 (ADDR_WIDTH             ),
    .LEN_WIDTH                  (LEN_WIDTH              )
)
u_test_data_gen (
    .clk                        (clk                    ),
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

// >>>>>>>>>> ddr4_top
ddr_top #(
    .MM2S_DATA_WIDTH            (MM2S_DATA_WIDTH        ),
    .S2MM_DATA_WIDTH            (S2MM_DATA_WIDTH        ),
    .MM2S_CMD_WIDTH             (MM2S_CMD_WIDTH         ),
    .S2MM_CMD_WIDTH             (S2MM_CMD_WIDTH         ),
    .MM2S_STS_WIDTH             (MM2S_STS_WIDTH         ),
    .S2MM_STS_WIDTH             (S2MM_STS_WIDTH         ),
    .ADDR_WIDTH                 (ADDR_WIDTH             ),
    .LEN_WIDTH                  (LEN_WIDTH              )
)
u_ddr_top (
    .clk                        (clk                    ),
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
    .ddr4_rtl_odt               (ddr4_rtl_odt           )
    );

endmodule
