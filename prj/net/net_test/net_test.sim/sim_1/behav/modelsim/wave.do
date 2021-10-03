onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider {New Divider}
add wave -noupdate /test_top/u_top/u_eth_wrap/fifo_block_i/s_axi_aclk
add wave -noupdate /test_top/u_top/u_eth_wrap/fifo_block_i/s_axi_awaddr
add wave -noupdate /test_top/u_top/u_eth_wrap/fifo_block_i/s_axi_awvalid
add wave -noupdate /test_top/u_top/u_eth_wrap/fifo_block_i/s_axi_awready
add wave -noupdate /test_top/u_top/u_eth_wrap/fifo_block_i/s_axi_wdata
add wave -noupdate /test_top/u_top/u_eth_wrap/fifo_block_i/s_axi_wvalid
add wave -noupdate /test_top/u_top/u_eth_wrap/fifo_block_i/s_axi_wready
add wave -noupdate /test_top/u_top/u_eth_wrap/fifo_block_i/s_axi_bresp
add wave -noupdate /test_top/u_top/u_eth_wrap/fifo_block_i/s_axi_bvalid
add wave -noupdate /test_top/u_top/u_eth_wrap/fifo_block_i/s_axi_bready
add wave -noupdate /test_top/u_top/u_eth_wrap/fifo_block_i/s_axi_araddr
add wave -noupdate /test_top/u_top/u_eth_wrap/fifo_block_i/s_axi_arvalid
add wave -noupdate /test_top/u_top/u_eth_wrap/fifo_block_i/s_axi_arready
add wave -noupdate /test_top/u_top/u_eth_wrap/fifo_block_i/s_axi_rdata
add wave -noupdate /test_top/u_top/u_eth_wrap/fifo_block_i/s_axi_rresp
add wave -noupdate /test_top/u_top/u_eth_wrap/fifo_block_i/s_axi_rvalid
add wave -noupdate /test_top/u_top/u_eth_wrap/fifo_block_i/s_axi_rready
add wave -noupdate /test_top/u_top/u_eth_wrap/fifo_block_i/tx_axis_fifo_tdata
add wave -noupdate /test_top/u_top/u_eth_wrap/fifo_block_i/tx_axis_fifo_tkeep
add wave -noupdate /test_top/u_top/u_eth_wrap/fifo_block_i/tx_axis_fifo_tvalid
add wave -noupdate /test_top/u_top/u_eth_wrap/fifo_block_i/tx_axis_fifo_tlast
add wave -noupdate /test_top/u_top/u_eth_wrap/fifo_block_i/tx_axis_fifo_tready
add wave -noupdate -divider {New Divider}
add wave -noupdate /test_top/u_top/u_eth_wrap/fifo_block_i/rx_axis_fifo_tdata
add wave -noupdate /test_top/u_top/u_eth_wrap/fifo_block_i/rx_axis_fifo_tkeep
add wave -noupdate /test_top/u_top/u_eth_wrap/fifo_block_i/rx_axis_fifo_tvalid
add wave -noupdate /test_top/u_top/u_eth_wrap/fifo_block_i/rx_axis_fifo_tlast
add wave -noupdate /test_top/u_top/u_eth_wrap/fifo_block_i/rx_axis_fifo_tready
add wave -noupdate -divider {New Divider}
add wave -noupdate -divider {New Divider}
add wave -noupdate -divider {New Divider}
add wave -noupdate -divider {New Divider}
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {716447 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {1365526 ps}
