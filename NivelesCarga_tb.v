`timescale 1ns / 1ps

module NivelesCarga_tb;
    // Entradas
    reg [3:0] carga_bateria1;
    reg [3:0] carga_bateria2;

    // Salidas
    wire optimo;
    wire aceptable;
    wire regular;
    wire critico;

    // Instancia del módulo bajo prueba (UUT - Unit Under Test)
    NivelesCarga uut (
        .carga_bateria1(carga_bateria1),
        .carga_bateria2(carga_bateria2),
        .optimo(optimo),
        .aceptable(aceptable),
        .regular(regular),
        .critico(critico)
    );

    // Proceso de simulación
    initial begin
        $dumpfile("niveles_carga.vcd");   // Nombre del archivo de señales
        $dumpvars(0, NivelesCarga_tb); // Volcar todas las variables del testbench
        // Inicialización de señales
        carga_bateria1 = 4'b0000;
        carga_bateria2 = 4'b0000;

        // Espera inicial
        #10;

        // Caso 1: 0% de carga (total = 0)
        carga_bateria1 = 4'd0;
        carga_bateria2 = 4'd0;
        #10;

        // Caso 2: 10% de carga (total = 3)
        carga_bateria1 = 4'd1;
        carga_bateria2 = 4'd2;
        #10;

        // Caso 3: 25% de carga (total = 8)
        carga_bateria1 = 4'd4;
        carga_bateria2 = 4'd4;
        #10;

        // Caso 4: 50% de carga (total = 15)
        carga_bateria1 = 4'd8;
        carga_bateria2 = 4'd7;
        #10;

        // Caso 5: 75% de carga (total = 23)
        carga_bateria1 = 4'd12;
        carga_bateria2 = 4'd11;
        #10;

        // Caso 6: 100% de carga (total = 30)
        carga_bateria1 = 4'd15;
        carga_bateria2 = 4'd15;
        #10;

        // Finaliza la simulación
        $stop;
    end

    // Monitoreo de señales
    initial begin
        $monitor("Tiempo: %0d | carga_bateria1: %d, carga_bateria2: %d | optimo: %b, aceptable: %b, regular: %b, critico: %b", 
                 $time, carga_bateria1, carga_bateria2, optimo, aceptable, regular, critico);
    end

endmodule