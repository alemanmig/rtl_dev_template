module test (
    vif_if vif
);

  // =================== MAIN SEQUENCE ==================== //

  initial begin
    // Initial values
    $display("Begin Of Simulation.");
    
    // Apply reset
   // reset();

    test1();

    // Drain time
    #(200ns);//tiempo mas largo que lo que espero que dure mi simulacion 
    $display("End Of Simulation.");
    $finish;
  end


  // ======================= TASKS ======================== //
/*
  task automatic reset();
    vif.rst_i = 1'b1;
    vif.up_i  = 1'b0;
    repeat (2) @(vif.cb);
    vif.cb.rst_i <= 1'b0;
    repeat (20) @(vif.cb);
  endtask : reset

*/
  task automatic test1();
    vif.x_i = 0;
    #30;
    vif.x_i = 1;
    #20;
    vif.x_i = 0;
    #25;
    vif.x_i = 1;
    #50;
    vif.x_i = 0;
  endtask : test1


endmodule : test
