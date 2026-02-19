module tb;

  timeunit      1ns;
  timeprecision 100ps;


  // Clock signal
  logic clk_i = 0;
  int unsigned MainClkPeriod = 10;  // 100 MHz -> 10 ns period
  always #(MainClkPeriod / 2) clk_i = ~clk_i;

  // Interface
  vif_if vif (clk_i);

  // Test
  test top_test (vif);

  // Instantiation
  counter 
    dut (
      .clk_i(vif.clk_i),
      .rst_i(vif.rst_i),
      .up_i(vif.up_i),
      .dout_o(vif.dout_o)
  );
  
  // SVA
  bind dut sva 
  dut_sva (
      .clk_i(vif.clk_i),
      .rst_i(vif.rst_i),
      .up_i(vif.up_i),
      .dout_o(vif.dout_o)
  );

  initial begin
    $timeformat(-9, 1, "ns", 10);
  end

endmodule : tb
