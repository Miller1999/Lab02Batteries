`timescale 1ns/1ps


module MonitorizacionBateria_tb;

    // Entradas
    reg [3:0] carga_bateria1;
    reg [3:0] carga_bateria2;

    // Salidas
    wire advertencia_bateria_1;
    wire advertencia_bateria_2;
    wire optimo;
    wire aceptable;
    wire regular;
    wire critico;

    // Instancia del módulo bajo prueba (DUT)
    MonitorizacionBateria dut (
        .carga_bateria1(carga_bateria1),
        .carga_bateria2(carga_bateria2),
        .advertencia_bateria_1(advertencia_bateria_1),
        .advertencia_bateria_2(advertencia_bateria_2),
        .optimo(optimo),
        .aceptable(aceptable),
        .regular(regular),
        .critico(critico)
    );

    // Procedimiento inicial
    initial begin
        $dumpfile("MonitorizacionBateria_tb.vcd");
        $dumpvars(0, MonitorizacionBateria_tb);

        // Caso 1: Ambas baterías completamente descargadas
        carga_bateria1 = 4'b0000;
        carga_bateria2 = 4'b0000;
        #10;

        // Caso 2: Una batería cargada a la mitad, otra vacía
        carga_bateria1 = 4'b1000;
        carga_bateria2 = 4'b0000;
        #10;

        // Caso 3: Ambas baterías a la mitad
        carga_bateria1 = 4'b1000;
        carga_bateria2 = 4'b1000;
        #10;

        // Caso 4: Una batería completamente cargada, otra vacía
        carga_bateria1 = 4'b1111;
        carga_bateria2 = 4'b0000;
        #10;

        // Caso 5: Ambas baterías completamente cargadas
        carga_bateria1 = 4'b1111;
        carga_bateria2 = 4'b1111;
        #10;

        // Caso 6: Baterías con valores intermedios
        carga_bateria1 = 4'b0101;
        carga_bateria2 = 4'b0110;
        #10;

        // Fin de simulación
        $finish;
    end

endmodule