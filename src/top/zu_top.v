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
module zu_top ();





// >>>>>>>>>> sys_cfg_wrap
sys_cfg_wrap #(
    .ADDR_WIDTH         (ADDR_WIDTH             ),
    .DATA_WIDTH         (DATA_WIDTH             ),
    .BYTE_NUM           (BYTE_NUM               )
)
u_sys_cfg_wrap (
    .clk                (clk                    ),
    .rstn               (rstn                   ),
    .bram_en            (bram_en                ),
    .bram_we            (bram_we                ),
    .bram_addr          (bram_addr              ),
    .bram_din           (bram_din               ),
    .bram_dout          (bram_dout              ),
    .reg_0              (reg_0                  ),
    .reg_1              (reg_1                  ),
    .reg_2              (reg_2                  ),
    .reg_3              (reg_3                  )
    );

// >>>>>>>>>> block_design


endmodule
