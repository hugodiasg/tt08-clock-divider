/*
 * Copyright (c) 2024 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module tt_um_hugodg_clock_divider (
    input  wire [7:0] ui_in,    // Dedicated inputs - connected to the input switches
    output wire [7:0] uo_out,   // Dedicated outputs - connected to the 7 segment display
    input  wire [7:0] uio_in,   // IOs: Bidirectional Input path
    output wire [7:0] uio_out,  // IOs: Bidirectional Output path
    output wire [7:0] uio_oe,   // IOs: Bidirectional Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // will go high when the design is enabled
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

  // All output pins must be assigned. If not used, assign to 0.
    assign uio_out[7:0] = 0; 
    assign uio_oe[7:0] = 8'b0;   
    assign uo_out[7:1] = 0; 

  // List all unused inputs to prevent warnings
    wire _unused = &{ena, 1'b0};

  // Instantiating the project
clock_divider clock_divider_inst(
    .clk_in(clk),
    .nrst(rst_n),
    .scale(ui_in[7:0]),
    .clk_out(uo_out[0])
  );
endmodule
