# SPDX-FileCopyrightText: © 2024 Tiny Tapeout
# SPDX-License-Identifier: Apache-2.0

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import ClockCycles


@cocotb.test()
async def test_project(dut):
    dut._log.info("Start")

    # Set the clock period to 10 us (100 KHz)
    clock = Clock(dut.clk, 10, units="us")
    cocotb.start_soon(clock.start())

    # Reset
    dut._log.info("Reset")
    dut.ena.value = 1
    dut.ui_in.value = 0
    dut.uio_in.value = 0
    dut.rst_n.value = 0
    await ClockCycles(dut.clk, 10)
    dut.rst_n.value = 1

    dut._log.info("Test project behavior")
    # Set the input values, wait (200_000 * dut.ui_in.value) clock cycles, and check the output
    dut._log.info("Test")

    # While to check if the clock is being divided
    CONST = 258000  # it should be equal to the CONST of src/clock_divider.v
    cycles = 0
    while True:
        await ClockCycles(dut.clk, 1)
        if dut.uo_out[0] == 1:
            break
        cycles += 1
    print(f"took {cycles} cycles")
    assert cycles == CONST / 2
    
