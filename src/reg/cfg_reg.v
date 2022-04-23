`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/09/05 14:30:29
// Design Name: 
// Module Name: cfg_reg
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
module cfg_reg #(
    parameter                           RST_VALUE   = 32'h0     ,
    parameter                           BASE_ADDR   = 32'h0     ,
    parameter                           ADDR_WIDTH  = 32        ,
    parameter                           DATA_WIDTH  = 32
)(
    // >>>>>>>>>> clock and reset
    input                               clk         ,
    input                               rstn        ,
    // >>>>>>>>>> config port
    input                               cfg_en      ,
    input       [ADDR_WIDTH-1:0]        cfg_addr    ,
    input       [DATA_WIDTH-1:0]        cfg_data    ,
    output  reg [DATA_WIDTH-1:0]        reg_data
    );

// >>>>>>>>>> reg_data
always @(posedge clk or negedge rstn) begin
    if(rstn == 1'd0)
        reg_data <= RST_VALUE;
    else if(cfg_en == 1'd1 && cfg_addr == BASE_ADDR)
        reg_data <= cfg_data;
end

endmodule