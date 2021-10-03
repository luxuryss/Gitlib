`timescale 1ns/1ps

module my_design(
    input                       clk     ,
    input                       rstn    ,
    input           [9 : 0]     din_a   ,
    input           [9 : 0]     din_b   ,
    output  reg     [10 : 0]    dout
);

always @(posedge clk or negedge rstn) begin
    if(rstn == 1'd0)
        dout <= 'd0;
    else
        dout <= din_a + din_b;
end

endmodule