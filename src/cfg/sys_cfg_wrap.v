`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/04/23 16:51:37
// Design Name: 
// Module Name: sys_cfg_wrap
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
module sys_cfg_wrap #(
    parameter                           ADDR_WIDTH  = 32,
    parameter                           DATA_WIDTH  = 32
)(
    // >>>>>>>>>> clock and reset
    input                               clk             ,
    input                               rstn            ,
    // >>>>>>>>>> axi_bram_controller
    input                               bram_cfg_en     ,
    input       [DATA_WIDTH/4-1:0]      bram_cfg_we     ,
    input       [ADDR_WIDTH-1:0]        bram_cfg_addr   ,
    input       [DATA_WIDTH-1:0]        bram_cfg_data   ,
    output      [DATA_WIDTH-1:0]        bram_cfg_rdbk   ,
    // >>>>>>>>>> sys_regs
    output      [DATA_WIDTH-1:0]        reg_0           ,
    output      [DATA_WIDTH-1:0]        reg_1           ,
    output      [DATA_WIDTH-1:0]        reg_2           ,
    output      [DATA_WIDTH-1:0]        reg_3
    );

// >>>>>>>>>> param
localparam                              BASE_ADDR   = 32'h0;

// >>>>>>>>>> cfg_regs
sys_cfg_regs #(
    .ADDR_WIDTH         (ADDR_WIDTH             ),
    .DATA_WIDTH         (DATA_WIDTH             )
)
u_sys_cfg_regs (
    .clk                (clk                    ),
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

endmodule
