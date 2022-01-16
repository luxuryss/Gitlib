import cocotb
from collections import deque
from cocotb.triggers import Timer
from cocotb.triggers import ClockCycles
from cocotb.triggers import RisingEdge 

class clock_domain(object):
    def __init__(self, clk_sig, clk_period, clk_unit, rst_sig, rst_active_high):
        self.clk                = clk_sig
        self.period             = clk_period
        self.unit               = clk_unit
        self.rst                = rst_sig
        self.rst_active_high    = rst_active_high
    async def rst_gen(self):
        if self.rst_active_high == 1:
            self.rst.value = 1
        else:
            self.rst.value = 0
        await ClockCycles(self.clk, 10, True)
        if self.rst_active_high == 1:
            self.rst.value = 0
        else:
            self.rst.value = 1
    async def clk_gen(self):
        self.clk.setimmediatevalue(0)
        while True:
            await Timer(self.period/2, self.unit)
            self.clk.setimmediatevalue(1)
            await Timer(self.period/2, self.unit)
            self.clk.setimmediatevalue(0)
    async def start(self):
        clk_thread = cocotb.fork(self.clk_gen())
        rst_thread = cocotb.fork(self.rst_gen())
        await rst_thread.join()
        return clk_thread

class input_driver(object):
    def __init__(self, din_vld, din_a, din_b, clk):
        self.din_vld        = din_vld
        self.din_a          = din_a
        self.din_b          = din_b
        self.clk            = clk
        self.task_q         = deque()
        self.result_q       = deque()
    async def din_seq_gen(self, transaction):
        self.din_vld.setimmedatevalue(0)
        cocotb.log.info("get a transaction in input driver")
        self.result_q.appendleft(transaction[0] + transaction[1])
        self.din_vld.value  = 1
        self.din_a.value    = transaction[0]
        self.din_b.value    = transaction[1]
        await RisingEdge(self.clk)
        self.din_vld.value  = 0
    async def task_monitor(self):
        while True:
            if len(self.task_q) != 0:
                await self.din_seq_gen(self.task_q.popleft())
            else:
                await RisingEdge(self.clk)
    def add_transaction(self, transaction):
        self.task_q.appendleft(transaction)

class output_monitor(object):
    def __init__(self, dout, dout_vld, clk):
        self.dout_vld   = dout_vld
        self.dout       = dout
        self.clk        = clk
        self.recv_q     = deque()
    async def task_monitor(self):
        while True:
            if self.dout_vld.value != 0:
                cocotb.log.info("get a transaction in output monitor")
                self.recv_q.appendleft(self.dout.value)
            await RisingEdge(self.clk)
    def get_recv_num(self):
        return len(self.recv_q)

class tb_adder(object):
    def __init__(self, dut):
        self.dut                = dut
        self.din_drv            = input_driver(dut.din_vld, dut.din_a, dut.din_b, dut.clk)
        self.dout_mon           = output_monitor(dut.dout, dut.dout_vld, dut.clk)
        self.clock_rst          = clock_domain(dut.clk, 10, 'ns', dut.rstn_in, 0)
    async def start(self):
        self.din_drv_thread     = cocotb.fork(self.din_drv.task_monitor())
        self.dout_mon_thread    = cocotb.fork(self.dout_mon.task_monitor())
        self.clock_rst_thread   = await self.clock_rst.start()
    def stop(self):
        self.din_drv_thread.kill()
        self.dout_mon_thread.kill()
        self.clock_rst_thread.kill()
    def add_transaction(self, transaction):
        self.din_drv.add_transaction(transaction)
    async def wait_all_done(self, trans_num):
        while not self.dout_mon.get_recv_num() == trans_num:
            await RisingEdge(self.dut.clk)
    def result_check(self):
        assert self.din_drv.result_q == self.dout_mon.recv_q

@cocotb.test()
async def run_test(dut):
    tb = tb_adder(dut)
    await tb.start()
    tb.add_transaction((3, 5))
    await Timer(100, 'ns')
    tb.add_transaction((7, 8))
    tb.add_transaction((17, 28))
    tb.add_transaction((47, 68))
    await tb.wait_all_done(4)
    tb.stop()
    tb.result_check()