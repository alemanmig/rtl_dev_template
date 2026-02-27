module sva (
    // Interface signals
    input logic clk_i,
    input logic x_i,
    input logic y_o
);
     
//ASSERTIONS de transicion de estados
// Estado 00 -> si x=1 pasa a 01, si x=0 se queda en 00
  trans_assert1: assert property (@(negedge clk_i) (dut.state==2'b00 && x_i==1) |=> dut.state==2'b01);
  trans_assert2: assert property (@(negedge clk_i) (dut.state==2'b00 && x_i==0) |=> dut.state==2'b00);

// Estado 01 -> si x=1 pasa a 10 si c=0 regresa a 00
  trans_assert3: assert property (@(negedge clk_i) (dut.state==2'b01 && x_i==1) |=> dut.state==2'b10);
  trans_assert4: assert property (@(negedge clk_i) (dut.state==2'b01 && x_i==0) |=> dut.state==2'b00);
  
// ASSERTIONS de salida

// y debe ser 1 unicamente si state==11 y x ==1
  trans_assert5: assert property (@(posedge clk_i) (y_o==1) |-> (dut.state==2'b11 && x_i==1));

// enc cualquier otro caso, y debe ser 0
  trans_assert6: assert property (@(posedge clk_i) (y_o==0) |-> !(dut.state==2'b11 && x_i==1));

 // Cover Property
 trans1_cover: cover property (@(posedge clk_i) (dut.state==2'b00 && x_i==1) |=> dut.state==2'b01);
 trans2_cover: cover property (@(posedge clk_i) dut.state==2'b00);

 trans3_cover: cover property (@(posedge clk_i) (dut.state==2'b01 && x_i==1) |=> dut.state==2'b10);

endmodule
