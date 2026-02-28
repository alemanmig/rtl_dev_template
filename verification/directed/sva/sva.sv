module sva (
    // Interface signals
    input logic clk_i,
    input logic x_i,
    input logic y_o
);

state1_2_state2 : assert property (@(negedge clk_i) (dut.state==2'b00 && x_i==1) |=> dut.state==2'b01);
 
state3_2_state1 : assert property (@(negedge clk_i) (dut.state==2'b10 && x_i==0) |=> dut.state==2'b00);

endmodule
