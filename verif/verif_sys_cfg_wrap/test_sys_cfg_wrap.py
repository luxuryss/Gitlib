import logging
import sys
sys.path.append("..")
from threading import Timer
import cocotb
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge
from verif_common import bram_port

CLK_PERIOD = 4.0

class testbench:
    def __init__(self, dut):
        self.dut = dut
        self.log = logging.getLogger("cocotb.tb")
        self.log.setLevel(logging.DEBUG)
        self.bram_port_cfg  = bram_port.bram_port_cfg(dut.clk, dut.bram_en, dut.bram_we, dut.bram_addr, dut.bram_din)
        #self.bram_port_rdbk = bram_port.bram_port_rdbk(dut.clk, dut.bram_en, dut.bram_we, dut.bram_addr, dut.bram_dout)
        cocotb.start_soon(Clock(dut.clk, CLK_PERIOD, units="ns").start())
        cocotb.start_soon(self.bram_port_cfg.cfg_task())
        #cocotb.start_soon(self.bram_port_rdbk.rdbk_task())

    async def reset(self):
        self.dut.rstn.setimmediatevalue(1)
        await RisingEdge(self.dut.clk)
        await RisingEdge(self.dut.clk)
        self.dut.rstn <= 0
        await RisingEdge(self.dut.clk)
        await RisingEdge(self.dut.clk)
        self.dut.rstn <= 1
        await RisingEdge(self.dut.clk)
        await RisingEdge(self.dut.clk)
    
    def check(self):
        assert self.bram_port_cfg.bram_aim_trans == self.bram_port_rdbk.bram_cfg_rdbk

@cocotb.test()
async def run_test_cfg_reg(dut, ):
    tb = testbench(dut)
    await tb.reset()
    trans = []
    trans['addr'] = 0x10004
    trans['data'] = 0xabcd
    tb.bram_port_cfg.add_transaction[trans]
    await Timer(20, 'ns')
    #tb.check()
