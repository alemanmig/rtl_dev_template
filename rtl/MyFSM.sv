module MyFSM(

        input clk_i,
        input rst_i,
        input x,
        output y);

    reg [1:0] state = 2'b00;

    assign y = state[1] & state[0] & x;

    always @ (negedge clk_i or posedge rst_i) begin 
        if (rst_i) begin 
            state  <= 2'b00;
        end
        else begin 
            case (state)

                2'b00: state <= x?2'b01:2'b00;

                2'b01: state <= x?2'b10:2'b00;

                2'b10: state <= x?2'b11:2'b00;

                2'b11: state <= 2'b00;

                default: state <= 2'b00;
            endcase
        end
    end
endmodule