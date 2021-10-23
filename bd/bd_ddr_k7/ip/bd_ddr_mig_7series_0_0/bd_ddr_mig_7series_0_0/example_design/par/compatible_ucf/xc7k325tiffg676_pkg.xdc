##################################################################################################
## 
##  Xilinx, Inc. 2010            www.xilinx.com 
##  Tue Oct  5 22:32:53 2021

##  Generated by MIG Version 4.2
##  
##################################################################################################
##  File name :       example_top.sd
##  Details :     Constraints file
##                    FPGA Family:       KINTEX7
##                    FPGA Part:         XC7K325TIFFG676_PKG
##                    Speedgrade:        -2
##                    Design Entry:      VERILOG
##                    Frequency:         800 MHz
##                    Time Period:       1250 ps
##################################################################################################

##################################################################################################
## Controller 0
## Memory Device: DDR3_SDRAM->Components->MT41K256M16XX-107
## Data Width: 64
## Time Period: 1250
## Data Mask: 1
##################################################################################################

set_property IO_BUFFER_TYPE NONE [get_ports {ddr3_ck_n[*]} ]
set_property IO_BUFFER_TYPE NONE [get_ports {ddr3_ck_p[*]} ]
          
#create_clock -period 1.25 [get_ports sys_clk_i]
          
#create_clock -period 5 [get_ports clk_ref_i]
          
############## NET - IOSTANDARD ##################


# PadFunction: IO_L24N_T3_16 
set_property IOSTANDARD LVCMOS25 [get_ports {init_calib_complete}]
set_property PACKAGE_PIN A12 [get_ports {init_calib_complete}]

# PadFunction: IO_L24P_T3_16 
set_property IOSTANDARD LVCMOS25 [get_ports {tg_compare_error}]
set_property PACKAGE_PIN A13 [get_ports {tg_compare_error}]

