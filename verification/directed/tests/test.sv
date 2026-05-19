module test (
    vif_if vif
);

  // =================== MAIN SEQUENCE ==================== //

  initial begin
    // Initial values
    $display("Begin Of Simulation.");
    
    // Apply reset
    reset();
    FSM_no();
    reset();
    //FSM_o();

    //count();

    // Drain time
    #(200ns);
    $display("End Of Simulation.");
    $finish;
  end


  // ======================= TASKS ======================== //
      // Interface signals

  task automatic FSM_o();
    vif.x_i = 1'b0;
    #5;
    vif.x_i = 1'b1; 
    #30;
    vif.x_i = 1'b0;
    #10;
    vif.x_i = 1'b1;    
    #40;
    vif.x_i = 1'b0;
    #50;
    vif.x_i= 1'b1;
  endtask : FSM_o

  task automatic FSM_no();
    vif.x_i = 1'b0;
    vif.rst_i = 1'b1;
    #5;
    vif.rst_i = 1'b0;
    vif.x_i = 1'b1; 
    #30;
    vif.rst_i = 1'b1;
    vif.x_i = 1'b0;
    #10;
    vif.rst_i = 1'b0;
    vif.x_i = 1'b1;    
    #40;
    vif.x_i = 1'b0;
    #50;
    vif.x_i= 1'b0;
  endtask : FSM_no


  
  task automatic reset();
    vif.rst_i = 1'b1;
    repeat (2) @(posedge vif.clk_i);
    vif.rst_i = 1'b0;
  endtask : reset


/*
  
  task automatic count();
    vif.rst_i = 1;
    vif.up_i = 0;
    #30;
    vif.rst_i = 0;
    vif.up_i = 1;
  #200;
    vif.up_i = 0;
    vif.rst_i = 1;
    #25;
    vif.rst_i = 0;
  endtask : count
  */



endmodule : test
