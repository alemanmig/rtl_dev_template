// Systemverilog Assertions (SVA)

module sva (
    input logic clk_i,
    input logic x_i,
    input logic y_o,
    input logic rst,
    input logic [1:0] state
);
  
    // Verificación del Reset: Si rst es 1, el estado DEBE ser 00 en el siguiente ciclo (o inmediato)
    property p_reset_logic;
       @(negedge clk_i) rst |-> (state == 2'b00);
    endproperty
    assert_reset: assert property (p_reset_logic);

    // -- ASSERTIONS (Propiedades de Seguridad) --

    // 1. Si estamos en 2'b00 y x es 1, el siguiente estado debe ser 2'b01
    property p_state_00_to_01;
        @(negedge clk_i) (state == 2'b00 && x_i) |=> (state == 2'b01);
    endproperty
    assert_00_01: assert property (p_state_00_to_01) else $error("Falla transicion 00->01");

    // 2. Si x es 0, la mayoría de los estados deben regresar a 2'b00 (excepto el estado final que siempre regresa)
    
    property p_reset_on_zero;
        @(negedge clk_i) (state != 2'b11 && !x_i) |=> (state == 2'b00);
    endproperty
    assert_p_reset: assert property (p_reset_on_zero);

    // 3. Verificación de la salida Mealy: y solo es 1 si estado es 2'b11 y x es 1
    property p_output_y;
        @(negedge clk_i) y_o |-> (state == 2'b11 && x_i);
    endproperty
      assert_output: assert property (p_output_y) else $error("Salida Y activa incorrectamente en t = %t", $time);

    // -- COVERAGE (Propiedades de Cobertura) --
    
    // -- Cobertura de Reset --
    cover_reset_hit: cover property (@(posedge rst) 1);

    cover_state_00: cover property (@(negedge clk_i) state == 2'b00);
    cover_state_01: cover property (@(negedge clk_i) state == 2'b01);
    cover_state_10: cover property (@(negedge clk_i) state == 2'b10);
    cover_state_11: cover property (@(negedge clk_i) state == 2'b11);
    cover_detection: cover property (@(negedge clk_i) y_o == 1);

endmodule