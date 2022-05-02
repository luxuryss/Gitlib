import cocotb
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge
from collections import deque
from threading import Timer

class bram_port_cfg:
    def __init__(self, clk, bram_en, bram_we, bram_addr, bram_din):
        self.clk            = clk
        self.bram_en        = bram_en
        self.bram_we        = bram_we
        self.bram_addr      = bram_addr
        self.bram_din       = bram_din
        self.bram_cfg_trans = deque()
        self.bram_aim_trans = deque()

    async def sequencer(self, transaction):
        self.bram_aim_trans.appendleft(transaction)
        self.bram_en    <= 1
        self.bram_we    <= 0xf
        self.bram_addr  <= transaction['addr']
        self.bram_din   <= transaction['data']
        await RisingEdge(self.clk)
        self.bram_en    <= 0
        self.bram_we    <= 0
        await RisingEdge(self.clk)
        await RisingEdge(self.clk)

    def add_transaction(self, transaction):
        self.cfg_trans.appendleft(transaction)

    async def cfg_task(self):
        while(True):
            if len(self.bram_cfg_trans):
                cocotb.log.info('send addr and data')
                await self.sequencer(self.cfg_trans.popleft())
            else:
                await RisingEdge(self.clk)

class bram_port_rdbk:
    def __init__(self, clk, bram_en, bram_we, bram_addr, bram_dout):
        self.clk            = clk
        self.bram_en        = bram_en
        self.bram_we        = bram_we
        self.bram_addr      = bram_addr
        self.bram_dout      = bram_dout
        self.bram_cfg_rdbk  = deque()

    async def rdbk_task(self):
        trans = []
        while(True):
            if self.bram_en.integer.value == 1 and self.bram_we.integer.value == 0xf:
                cocotb.log.info('recv addr and data')
                await Timer(self.clk, 'ns')
                trans['addr'] = self.bram_addr
                trans['data'] = self.bram_dout
                self.bram_cfg_rdbk.appendleft(trans)
            await RisingEdge(self.clk)