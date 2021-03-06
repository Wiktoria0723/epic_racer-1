// File: testbench.v
// file downloaded from:
// https://upel2.cel.agh.edu.pl/weaiib/pluginfile.php/61442/mod_assign/introattachment/0/MTM_UEC_lab2_1_ee178_spring2017_lab4.zip?forcedownload=1
// This is a top level testbench for the
// vga_example design, which is part of
// the EE178 Lab #4 assignment.

// The `timescale directive specifies what the
// simulation time units are (1 ns here) and what
// the simulator time step should be (1 ps here).

`timescale 1 ns / 1 ps

module testbench;

  // Declare wires to be driven by the outputs
  // of the design, and regs to drive the inputs.
  // The testbench will be in control of inputs
  // to the design, and will check the outputs.
  // Then, instantiate the design to be tested.

  reg clk;
  reg rst;
  wire pclk_mirror;
  wire vs, hs;
  wire [3:0] r, g, b;
  
  epic_racer my_epic_racer (
    .clk(clk),
    .rst(rst),
    .vs(vs),
    .hs(hs),
    .r(r),
    .g(g),
    .b(b),
    .pclk_mirror(pclk_mirror)
  );

  // Instantiate the tiff_writer module.

  tiff_writer my_writer (
    .pclk_mirror(pclk_mirror),
    .r({r,r}), // fabricate an 8-bit value
    .g({g,g}), // fabricate an 8-bit value
    .b({b,b}), // fabricate an 8-bit value
    .go(vs),
    .xdim(16'd1344),
    .ydim(16'd806)
  );

  // Describe a process that generates a clock
  // signal. The clock is 100 MHz.
initial
begin
    rst = 1;
    #10
    rst = 0;
end

  always
  begin
    clk = 1'b0;
    #5;
    clk = 1'b1;
    #5;
  end

  // Assign values to the input signals and
  // check the output results. This template
  // is meant to get you started, you can modify
  // it as you see fit. If you simply run it as
  // provided, you will need to visually inspect
  // the output waveforms to see if they make
  // sense...

  initial
  begin
    $display("If simulation ends before the testbench");
    $display("completes, use the menu option to run all.");
    $display("Prepare to wait a long time...");
    wait (vs == 1'b0);
    @(negedge vs) $display("Info: negedge VS at %t",$time);
    @(negedge vs) $display("Info: negedge VS at %t",$time);
    // End the simulation.
    $display("Simulation is over, check the waveforms.");
    $stop;
  end

endmodule
