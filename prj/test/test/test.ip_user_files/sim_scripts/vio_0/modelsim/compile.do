vlib modelsim_lib/work
vlib modelsim_lib/msim

vlib modelsim_lib/msim/xil_defaultlib
vlib modelsim_lib/msim/xpm

vmap xil_defaultlib modelsim_lib/msim/xil_defaultlib
vmap xpm modelsim_lib/msim/xpm

vlog -work xil_defaultlib -64 -incr -sv "+incdir+../../../ip/vio_0/hdl/verilog" "+incdir+../../../ip/vio_0/hdl" \
"D:/Software/Vivado/Vivado/2018.3/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \

vcom -work xpm -64 -93 \
"D:/Software/Vivado/Vivado/2018.3/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work xil_defaultlib -64 -incr "+incdir+../../../ip/vio_0/hdl/verilog" "+incdir+../../../ip/vio_0/hdl" \
"../../../ip/vio_0/sim/vio_0.v" \


vlog -work xil_defaultlib \
"glbl.v"

