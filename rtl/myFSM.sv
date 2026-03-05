// RTL MyFSM

module myFSM(
    input clk_i,
    input rst,    // Nueva señal de Reset (Activa en alto)
    input x_i,
    output y_o
);
    reg [1:0] state;

    assign y_o = (state == 2'b11) & x_i;

    // Reset asíncrono sensible al flanco de subida de 'rst'
    always @ (negedge clk_i or posedge rst) begin
        if (rst) begin
            state <= 2'b00;
        end else begin
            case (state)
                2'b00: state <= x_i ? 2'b01 : 2'b00;
                2'b01: state <= x_i ? 2'b10 : 2'b00;
                2'b10: state <= x_i ? 2'b11 : 2'b00;
                2'b11: state <= 2'b00;
                default: state <= 2'b00; // Cláusula de seguridad
            endcase
        end
    end
endmodule