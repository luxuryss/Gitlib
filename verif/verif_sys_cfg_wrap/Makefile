# common parameters
TOPLEVEL_LANG 	?= verilog
SIM 			?= questa
WAVES 			?= 1
GUI 			?= 1
COCOTB_HDL_TIMEUNIT 		= 1ns
COCOTB_HDL_TIMEPRECISION 	= 1ps

# sources
DUT 			= sys_cfg_wrap
TOPLEVEL 		= $(DUT)
MODULE 			= test_$(DUT)

VERILOG_SOURCES += ../../src/cfg/sys_cfg_wrap.v
VERILOG_SOURCES += ../../src/reg/sys_cfg_regs.v
VERILOG_SOURCES += ../../src/reg/cfg_reg.v

# module parameters
export PARAM_ADDR_WIDTH ?= 32
export PARAM_DATA_WIDTH ?= 32
export PARAM_BYTE_NUM	?= 4

# compile parameters
ifeq ($(SIM), questa)
	SIM_ARGS += -g ADDR_WIDTH=$(PARAM_ADDR_WIDTH)
	SIM_ARGS += -g DATA_WIDTH=$(PARAM_DATA_WIDTH)
	SIM_ARGS += -g BYTE_NUM=$(PARAM_BYTE_NUM)
endif

# cocotb makefile
include $(shell cocotb-config --makefiles)/Makefile.sim