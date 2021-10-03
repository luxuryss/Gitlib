vlib modelsim_lib/work
vlib modelsim_lib/msim

vlib modelsim_lib/msim/xil_defaultlib

vmap xil_defaultlib modelsim_lib/msim/xil_defaultlib

vlog -work xil_defaultlib -64 -incr "+incdir+../../../ip/vio_cfg/hdl/verilog" "+incdir+../../../ip/vio_cfg/hdl" \
"../../../ip/vio_cfg/sim/vio_cfg.v" \


vlog -work xil_defaultlib \
"glbl.v"

