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

  // Maquina de estados
  MyFSM dut(
    .clk_i(vif.clk_i),
    .rst_i(vif.rst_i),
    .x(vif.x_i),
    .y(vif.y_o)
  );

  // SVA
  bind dut sva 
  dut_sva (
      .clk_i(vif.clk_i),
      .rst_i(vif.rst_i),
      .x_i(vif.x_i),
      .y_o(vif.y_o)
  );
  

  initial begin
    $timeformat(-9, 1, "ns", 10);
  end

endmodule : tb
