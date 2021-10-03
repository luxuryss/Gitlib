`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/09/21 11:35:11
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
module test_top(
    input               clk_in
    );

// >>>>>>>>>> var
localparam              WIDTH   = 32;
wire                    clk_100m, clk_250m, clk_500m, rstn;
wire    [3 : 0][31 : 0] cfg_reg;
reg     [WIDTH-1 : 0]   data;

// >>>>>>>>>> clk
clk_wiz_0 u_clk_wiz (
    .clk_in1        (clk_in         ),
    .reset          (1'd0           ),
    .clk_100m       (clk_100m       ),
    .clk_250m       (clk_250m       ),
    .clk_500m       (clk_500m       ),
    .locked         (rstn           )
 );

// >>>>>>>>>> vio
vio_0 u_vio (
    .clk            (clk_100m       ),
    .probe_in0      ({32'd0, data}  ),
    .probe_out0     (cfg_reg[0]     ),
    .probe_out1     (cfg_reg[1]     ),
    .probe_out2     (cfg_reg[2]     ),
    .probe_out3     (cfg_reg[3]     )
);

// >>>>>>>>>> add
always @(posedge clk_500m or negedge rstn) begin
    if(rstn == 1'd0)
        data <= 'd0;
    else
        data <= cfg_reg[0][WIDTH-1 : 0] + cfg_reg[1][WIDTH-1 : 0];
end

endmodule
