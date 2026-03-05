module tb;

  timeunit      1ns;
  timeprecision 100ps;


  // Clock signal
  logic clk_i = 0;
  int unsigned MainClkPeriod = 10;  // 100 MHz -> 10 ns period
  always #(MainClkPeriod / 2) clk_i = ~clk_i;

  // Interface
  vif_if vif (clk_i); //virtual interface 

  // Test
  test top_test (vif); //generar las señales 

  // Instantiation
  myFSM 
    dut (
      .clk_i(vif.clk_i),
      .x_i(vif.x_i),
      .y_o(vif.y_o), 
      .rst(vif.rst)
  );
  
  //SVA
  bind dut sva 
  dut_sva (
      .clk_i(vif.clk_i),
      .x_i(vif.x_i), 
      .y_o(vif.y_o),
      .rst(vif.rst)
  );

  initial begin
    $timeformat(-9, 1, "ns", 10);
  end

endmodule : tb
