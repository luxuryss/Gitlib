`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/09/05 17:46:36
// Design Name: 
// Module Name: sim_clk_rst
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
module sim_clk_rst(
    output  reg                 clk_156p25m     ,
    output  reg                 clk_100m        ,
    output  reg                 clk_125m        ,
    output  reg                 clk_200m        ,
    output  reg                 clk_250m        ,
    output  reg                 rstn
    );

// >>>>>>>>>> clk
initial begin
    clk_156p25m = 1'd0;
    clk_100m    = 1'd0;
    clk_125m    = 1'd0;
    clk_200m    = 1'd0;
    clk_250m    = 1'd0;
end

always begin
    clk_156p25m = #(3.2) ~clk_156p25m;
end

always begin
    clk_100m = #(5) ~clk_100m;
end

always begin
    clk_125m = #(4) ~clk_125m;
end

always begin
    clk_200m = #(2.5) ~clk_200m;
end

always begin
    clk_250m = #(2) ~clk_250m;
end

// >>>>>>>>>> rstn
initial begin
    rstn = 1'd1;
    #10;
    rstn = 1'd0;
    #500;
    rstn = 1'd1;
end

endmodule
