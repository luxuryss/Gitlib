import random
import cocotb
from cocotb.triggers import Clock
from cocotb.triggers import FallingEdge

@cocotb.test()
async def test_dff_simple(dut):
    """ Test that d propagates to q """

    clock = Clock(dut.clk, 10, units="us")  # Create a 10us period clock on port clk
    cocotb.start_soon(clock.start())  # Start the clock

    for i in range(10):
        val_1 = random.randint(0, 1024)
        val_2 = random.randint(0, 1024)
        dut.din_a.value = val_1  # Assign the random value val to the input port d
        dut.din_b.value = val_2
        await FallingEdge(dut.clk)
        assert dut.dout.value == val_1 + val_2, "output q was incorrect on the {}th cycle".format(i)