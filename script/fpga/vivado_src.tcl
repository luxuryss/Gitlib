# .v文件(glob .v是扫描目录下所有v文件)
read_verilog [glob D:/Software/Vivado/project/COMM_SYSTEM/COMM_SYSTEM.srcs/sources_1/new/*.v]  

# .xci文件
read_ip [glob D:/Software/Vivado/project/COMM_SYSTEM/COMM_SYSTEM.srcs/sources_1/ip/block_ram_12_8192/*.xci]
read_ip [glob D:/Software/Vivado/project/COMM_SYSTEM/COMM_SYSTEM.srcs/sources_1/ip/block_ram_16_256/*.xci]
read_ip [glob D:/Software/Vivado/project/COMM_SYSTEM/COMM_SYSTEM.srcs/sources_1/ip/clk_160mhz/*.xci]
read_ip [glob D:/Software/Vivado/project/COMM_SYSTEM/COMM_SYSTEM.srcs/sources_1/ip/fft_16_256/*.xci]
read_ip [glob D:/Software/Vivado/project/COMM_SYSTEM/COMM_SYSTEM.srcs/sources_1/ip/mult_16_16/*.xci]
read_ip [glob D:/Software/Vivado/project/COMM_SYSTEM/COMM_SYSTEM.srcs/sources_1/ip/rom_12_8128_i/*.xci]
read_ip [glob D:/Software/Vivado/project/COMM_SYSTEM/COMM_SYSTEM.srcs/sources_1/ip/rom_12_8128_q/*.xci]

# .xdc文件
read_xdc [glob D:/Software/Vivado/project/COMM_SYSTEM/COMM_SYSTEM.srcs/constrs_1/new/*.xdc] 