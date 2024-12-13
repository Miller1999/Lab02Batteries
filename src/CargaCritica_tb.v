`timescale 1ns/1ps

module CargaCritica_tb;

    // Declarar señales para las entradas y salidas del DUT (Device Under Test)
    reg [3:0] carga_bateria1;  // Entrada para la batería 1
    reg [3:0] carga_bateria2;  // Entrada para la batería 2
    wire advertencia_critica;  // Salida de advertencia crítica
    wire [4:0] carga_total;    // Salida interna de la carga total

    // Instanciar el módulo bajo prueba (DUT)
    CargaCritica dut (
        .carga_bateria1(carga_bateria1),
        .carga_bateria2(carga_bateria2),
        .advertencia_critica(advertencia_critica)
    );

    // Procedimiento inicial para aplicar los estímulos
    initial begin
        $dumpfile("carga_critica.vcd");   // Nombre del archivo de señales
        $dumpvars(0, CargaCritica_tb); // Volcar todas las variables del testbench
        // Mostrar un encabezado en la simulación
        $display("Tiempo\tCarga Batería 1\tCarga Batería 2\tCarga Total\tAdvertencia Crítica");
        $monitor("%0dns\t%b\t\t%b\t\t%b\t\t%b", $time, carga_bateria1, carga_bateria2, dut.carga_total, advertencia_critica);

        // Prueba 1: Cargas normales, sin advertencia crítica
        carga_bateria1 = 4'b0100;  // Carga 4
        carga_bateria2 = 4'b0011;  // Carga 3
        #10;

        // Prueba 2: Suma igual a 3 (advertencia activa)
        carga_bateria1 = 4'b0001;  // Carga 1
        carga_bateria2 = 4'b0010;  // Carga 2
        #10;

        // Prueba 3: Suma menor a 3 (advertencia activa)
        carga_bateria1 = 4'b0001;  // Carga 1
        carga_bateria2 = 4'b0001;  // Carga 1
        #10;

        // Prueba 4: Una batería descargada, otra cargada (sin advertencia)
        carga_bateria1 = 4'b0000;  // Descargada
        carga_bateria2 = 4'b0111;  // Carga 7
        #10;

        // Prueba 5: Ambas baterías cargadas al máximo (sin advertencia)
        carga_bateria1 = 4'b1111;  // Carga máxima 15
        carga_bateria2 = 4'b1111;  // Carga máxima 15
        #10;

        // Prueba 6: Ambas baterías descargadas (advertencia activa)
        carga_bateria1 = 4'b0000;  // Descargada
        carga_bateria2 = 4'b0000;  // Descargada
        #10;

        // Finalizar la simulación
        $finish;
    end

endmodule
