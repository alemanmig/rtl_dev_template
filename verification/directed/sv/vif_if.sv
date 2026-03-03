`ifndef VIF_IF_SV
`define VIF_IF_SV

interface vif_if(
    input logic clk_i
); 

  timeunit      1ns;
  timeprecision 100ps;
  
  logic x_i;
  logic y_o;
  //logic [3:0] dout_o;

 /* clocking cb @(posedge clk_i);
    default input #1ns output #1ns;
    output rst_i;
    output up_i;
  endclocking
*/

endinterface : vif_if

`endif // VIF_IF_SV
