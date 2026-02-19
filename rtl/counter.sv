module counter(
 input clk_i,
 input rst_i,
 input up_i,
 output reg [3:0] dout_o);
  
  always@(posedge clk_i,posedge rst_i)
    begin
      if(rst_i == 1'b1)
         dout_o <= 0;
      else begin
        if(up_i == 1'b1)
           dout_o <= dout_o + 1;
        else
           dout_o <= dout_o - 1;
      end
    end
  
  
endmodule 