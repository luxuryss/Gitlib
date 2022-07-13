`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/04/23 18:10:36
// Design Name: 
// Module Name: rstn_sync
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
module rstn_sync (
    // >>>>>>>>>> clk & rst
    input                   clk_in      ,
    input                   rstn_in     ,
    // >>>>>>>>>> rst_sync
    output                  rstn_sync
    );

// >>>>>>>>>> var
reg     [2:0]               rstn_reg;

// >>>>>>>>>> sync
assign rstn_sync    = rstn_reg[2];
always @(posedge clk_in or negedge rstn_in) begin
    if(rstn_in == 1'd0) begin
        rstn_reg[0] <= 1'd0;
        rstn_reg[1] <= 1'd0;
        rstn_reg[2] <= 1'd0;
    end
    else begin
        rstn_reg[0] <= 1'd1;
        rstn_reg[1] <= rstn_reg[0];
        rstn_reg[2] <= rstn_reg[1];
    end
end

endmodule
