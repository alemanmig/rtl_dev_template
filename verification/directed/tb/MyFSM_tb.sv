module  MyFSM_tb    ();

timeunit      1ns;
timeprecision 100ps;

logic   clk;
logic   x;
logic   y;

MyFSM    dut    (
    .clk    (clk),
    .x      (x  ),
    .y      (y  )
);

initial begin
    #0;
    clk=1'b0;
    x=1'b0;
    #10 x=1'b1;
    #30 x=1'b0;
    #20 x=1'b1;
end
always  #5  clk=~clk;

endmodule