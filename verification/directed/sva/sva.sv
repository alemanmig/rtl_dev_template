module sva (
    // Interface signals
    input logic clk_i,
    input logic rst_i,
    input logic x_i,  
    input logic y_o
);

  //property post_rst;
  // (rst_i ==1'b1) |-> (dut.state == 2'b00); 
  //endproperty

  // cambio de estado 00 a 01 
  property s0_to_s1;
   @(negedge clk_i) disable iff(rst_i)
   (x_i == 1'b1 && dut.state ==2'b00) |-> dut.state ==2'b01;
  endproperty

    // cambio de estado 01 a 10 
  property s1_to_s2;
   @(negedge clk_i) disable iff(rst_i)
   (x_i == 1'b1 && dut.state ==2'b01) |-> dut.state ==2'b10;
  endproperty

    // cambio de estado 10 a 11 
  property s2_to_s3;
   @(negedge clk_i) disable iff(rst_i)
   (x_i == 1'b1 && dut.state ==2'b10) |-> dut.state ==2'b11;
  endproperty

    // cambio de estado 11 a 00 
  property s3_to_s0;
   @(negedge clk_i) disable iff(rst_i)
   (x_i == 1'b1 && dut.state ==2'b11) | (x_i == 1'b0 && dut.state ==2'b11) |-> dut.state ==2'b00;
  endproperty

  property output_w;
  @(negedge clk_i) disable iff (rst_i)
    (x_i == 1'b1 && dut.state ==2'b11) |-> (y_o == 1'b1);
  endproperty

  //check_rst: assert property (post_rst)
  //  else $error("reset is not working");

  state0_state1: assert property (s0_to_s1)
    else $error("S0 to S1 is not working");

  state1_state2: assert property (s1_to_s2)
    else $error("S1 to S2 is not working");

  state2_state3: assert property (s2_to_s3)
    else $error("S2 to S3 is not working");
  
  state3_state0: assert property (s3_to_s0)
    else $error("S3 to S0 is not working");

  state3_out: assert property (output_w)
    else $error("Output is not working");

endmodule
