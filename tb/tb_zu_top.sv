`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/10/2022 04:08:07 PM
// Design Name: 
// Module Name: tb_zu_top
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
module tb_zu_top(

    );

// >>>>>>>>>> dump_fsdb
initial begin
    $fsdbDumpfile("tb_zu_top.fsdb");
    $fsdbDumpvars("+all");
    $fsdbDumpSVA();
    $fsdbDumpMDA();
    #100us;
    $finish(2);
end

// >>>>>>>>>> force
initial begin
    #2us;
    force u_zu_top.test_en = 1'd1;
    force u_zu_top.test_addr = 'h1000_0000;
    force u_zu_top.test_size = 'd1024;
    #10ns;
    force u_zu_top.test_en = 1'd0;
end

initial begin
    force u_zu_top.u_bd_wrap.ps_rstn = 1'd1;
    #1us;
    force u_zu_top.u_bd_wrap.ps_rstn = 1'd0;
    #100ns;
    force u_zu_top.u_bd_wrap.ps_rstn = 1'd1;
end

// >>>>>>>>>> dut
zu_top u_zu_top();

endmodule
