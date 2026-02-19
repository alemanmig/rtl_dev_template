module sva (
    // Interface signals
    input logic clk_i,
    input logic rst_i,
    input logic up_i,
    input logic [3:0] dout_o
);
     
// (1) Behavior of the dout when rst asserted
// dout is zero in next clock tick after rst
  
  DOUT_RST_ASRT_1: assert property (@(posedge clk_i) $rose(rst_i) |=> (dout_o == 0));
  
// dout is zero for all clock ticks during rst
  DOUT_RST_ASRT_2: assert property (@(posedge clk_i) rst_i |-> (dout_o == 0));
  
// dout remain stable to zero for entire duration of rst
    
  DOUT_RST_ASRT_3: assert property (@(posedge clk_i) $rose(rst_i) |=> rst_i throughout ((dout_o == 0)[*1:36]));

   
// (2) dout is unknown anywhere in the simulation
    
// dout_o must be valid after rst deassert
    
  DOUT_UNKNW_1: assert property(@(posedge clk_i) $fell(rst_i) |-> !$isunknown(dout_o));
    
// dout must be valid for all clock edges

   always@(posedge clk_i)
    begin
     DOUT_UNKNW_2: assert(!$isunknown(dout_o));
    end     
  
// (3)   verifying up and down state of the counter  */
  
     
// current value of dout must be one greater than previous value when up = 1
     
  UP_MODE_1: assert property (@(posedge clk_i) disable iff(rst_i) up_i |-> (dout_o == $past(dout_o + 1)) || (dout_o == 0));
  
// next value must be greater than zero when up = 1 and rst = 0 
  
  UP_MODE_2: assert property (@(posedge clk_i) $fell(rst_i) |=> (dout_o != 0));   
  UP_MODE_3: assert property (@(posedge clk_i) $fell(rst_i) |-> up_i[->1] ##1 !$stable(dout_o));

// current value of dout must be one less than previous value when up = 0
  
  DOWN_MODE_1: assert property (@(posedge clk_i) disable iff(rst_i) !up_i |-> (dout_o == $past(dout_o - 1)) || (dout_o == 0) || ($past(dout_o) == 0));
  
 
// next value must not be equal to zero when up = 0 and rst = 0   
  DOWN_MODE_2: assert property(@(posedge clk_i) (!up_i && !rst_i) |=> !$stable(dout_o));   

// alternate way 
 
 property p1;
   if(up_i)
     ((dout_o == $past(dout_o + 1)) || (dout_o == 0))
     else
       ((dout_o == $past(dout_o - 1)) || (dout_o == 0) || ($past(dout_o) == 0)); 
 endproperty

  BOTH_MODE_1:assert property(@(posedge clk_i) !rst_i |-> p1);
 

endmodule
