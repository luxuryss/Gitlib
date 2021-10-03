# -------------------------------- Vivado工程配置 ------------------------------------ #
# ----------- 名称、fpga型号、输出路径 ------------ #
set output_dir ./project/test1
set design_name COMM_SYS
set fpga_device xc7z020clg400-2
set top_module comm_system_top

# ----------- 综合参数 --------------------------- #
set gated_clock_conversion on

# ----------- 实现参数 --------------------------- #

# -------------------------------- Vivado工程执行 ------------------------------------ #
# ----------- 生成输出路径的目标文件夹 ------------ #
file mkdir $output_dir
set_part $fpga_device

# ----------- 读取设计文件和约束文件 -------------- #
source ./vivado_src.tcl

# ----------- 综合------------------------------- #
synth_design -name $design_name -top $top_module -part $fpga_device -gated_clock_conversion $gated_clock_conversion

# 综合后写入一个检查点, 生成各类报告(时序、资源、功耗等), 最好与Vivado GUI一致以达到相同效果, 也可以定制报告(report_xxx -file)
write_checkpoint -force $output_dir/post_synth
report_utilization -file $output_dir/post_synth_utilization.rpt

# DEBUG

# ----------- 实现------------------------------- #
# 对设计进行优化，优化操作一般都需要指定一些参数
opt_design

# ------------布局------------ #
place_design

# 布局后写入一个设计检查点, 生成各类报告
write_checkpoint -force $output_dir/post_place
report_utilization -file $output_dir/post_place_utilization.rpt
report_io -file $output_dir/post_place_io.rpt
report_control_sets -file $output_dir/post_place_control_sets.rpt

# ------------布线------------ #
route_design

# 布线后写入一个检查点, 生成各类报告
write_checkpoint -force $output_dir/post_route
report_drc -file $output_dir/post_route_drc.rpt
report_methodology -file $output_dir/post_route_methodology.rpt
report_power -file $output_dir/post_route_power.rpt
report_route_status -file $output_dir/post_route_status.rpt
report_timing_summary -file $output_dir/post_route_timing_summary.rpt
report_incremental_reuse -file $output_dir/post_route_incremental_reuse.rpt
report_clock_utilization -file $output_dir/post_route_clock_util.rpt
report_bus_skew -file $output_dir/post_route_bus_skew.rpt
report_utilization -file $output_dir/post_route_utilization.rpt
report_timing -sort_by group -max_paths 100 -path_type summary -file $output_dir/post_route_timing.rpt

# ------------bit生成--------- #
write_bitstream -force $output_dir/$design_name.bit