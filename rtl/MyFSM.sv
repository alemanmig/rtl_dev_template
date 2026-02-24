module MyFSM(
        input clk_i,
        input x_i,
        output y_o);

    reg [1:0] state = 2'b00;

    assign y_o = state[1] & state[0] & x_i;

    always @ (negedge clk_i)
        case (state)
            2'b00: state <= x_i?2'b01:2'b00;
            2'b01: state <= x_i?2'b10:2'b00;
            2'b10: state <= x_i?2'b11:2'b00;
            2'b11: state <= 2'b00;
        endcase

endmodule