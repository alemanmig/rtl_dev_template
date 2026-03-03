module sva (
    // Interface signals
    input logic clk_i,
    input logic x_i,
    input logic y_o
);
     
// Estado 00 -> si x = 1 pasa a 01, si x= 0 se queda en 00
  
  assert property (@(negedge clk_i) (dut.state == 2'b00 && x_i ==0) |=> dut.state == 2'b00);
  
  
// ASSERTIONS DE SALIDA

//y debe ser 1 unicamente si state == 11 y x == 1
  
  assert property (@(posedge clk_i) (y_o==1) |-> (dut.state==1'b11 && x_i == 1));

 
 

endmodule
