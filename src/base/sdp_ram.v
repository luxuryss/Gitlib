module sdp_ram #(
    parameter                           DATA_WIDTH  = 16    ,
    parameter                           DATA_DEPTH  = 1024
)(
    input                               clk         ,
    input                               wr_en       ,
    input   [$clog2(DATA_DEPTH)-1 : 0]  wr_addr     ,
    input   [DATA_WIDTH-1 : 0]          wr_data     ,
    input                               rd_en       ,
    input   [$clog2(DATA_DEPTH)-1 : 0]  rd_addr     ,
    output  [DATA_WIDTH-1 : 0]          rd_data
)
//
reg     [DATA_DEPTH-1 : 0][DATA_WIDTH-1 : 0]  mem_data;
//
always @(posedge clk) begin
    if(wr_en == 1'd1)
        mem_data[wr_addr] <= wr_data;
end
always @(posedge clk) begin
    if(rd_en == 1'd1)
        rd_data <= mem_data[rd_addr];
end