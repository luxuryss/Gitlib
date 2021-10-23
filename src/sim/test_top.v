`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/10/23 21:02:44
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

// >>>>>>>>>> var
wire                        clk_100m, clk_125m, clk_156p25m, clk_200m, clk_250m, clk_500m, rstn;

// >>>>>>>>>> clk & rst
sim_clk_rst u_sim_clk_rst(
    .clk_156p25m            (clk_156p25m        ),
    .clk_100m               (clk_100m           ),
    .clk_125m               (clk_125m           ),
    .clk_200m               (clk_200m           ),
    .clk_250m               (clk_250m           ),
    .clk_500m               (clk_500m           ),
    .rstn                   (rstn               )
    );

// >>>>>>>>>> top
ku_top u_ku_top(
    .clk                    (clk_200m           ),
    .rstn                   (rstn               ),
    .ddr4_clk_p             (clk_100m           ),
    .ddr4_clk_n             (~clk_100m          )
    );

endmodule
