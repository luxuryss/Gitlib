`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/04/23 18:10:13
// Design Name: 
// Module Name: clk_rst_gen
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
module clk_rst_gen (
    // >>>>>>>>>> ps_clk_in
    input                           ps_clk_100m         ,
    input                           ps_clk_125m         ,
    input                           ps_clk_250m         ,
    input                           ps_clk_300m         ,
    input                           ps_rstn             ,
    // >>>>>>>>>> sys_clk_out
    output                          pl_clk_100m         ,
    output                          pl_clk_125m         ,
    output                          pl_clk_250m         ,
    output                          pl_clk_300m         ,
    output                          pl_rstn_100m        ,
    output                          pl_rstn_125m        ,
    output                          pl_rstn_250m        ,
    output                          pl_rstn_300m
    );

// >>>>>>>>>> pl_clk_out
assign pl_clk_100m      = ps_clk_100m;
assign pl_clk_125m      = ps_clk_125m;
assign pl_clk_250m      = ps_clk_250m;
assign pl_clk_300m      = ps_clk_300m;

// >>>>>>>>>> pl_rstn_out
rstn_sync u_rstn_100m (
    .clk_in             (ps_clk_100m        ),
    .rstn_in            (ps_rstn            ),
    .rstn_sync          (pl_rstn_100m       )
    );

rstn_sync u_rstn_125m (
    .clk_in             (ps_clk_125m        ),
    .rstn_in            (ps_rstn            ),
    .rstn_sync          (pl_rstn_125m       )
    );

rstn_sync u_rstn_250m (
    .clk_in             (ps_clk_250m        ),
    .rstn_in            (ps_rstn            ),
    .rstn_sync          (pl_rstn_250m       )
    );

rstn_sync u_rstn_300m (
    .clk_in             (ps_clk_300m        ),
    .rstn_in            (ps_rstn            ),
    .rstn_sync          (pl_rstn_300m       )
    );

endmodule
