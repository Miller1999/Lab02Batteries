`timescale 1ns/1ps


module DetectarBateriasDescargada_tb;

    // Declaración de señales para entradas y salidas
    reg [3:0] carga_bateria1;  // Entrada de carga de la batería 1
    reg [3:0] carga_bateria2;  // Entrada de carga de la batería 2
    wire advertencia_bateria_1;  // Advertencia para la batería 1
    wire advertencia_bateria_2;  // Advertencia para la batería 2

    // Instanciación del módulo bajo prueba (DUT)
    DetectarBateriasDescargada dut (
        .carga_bateria1(carga_bateria1),
        .carga_bateria2(carga_bateria2),
        .advertencia_bateria_1(advertencia_bateria_1),
        .advertencia_bateria_2(advertencia_bateria_2)
    );

    // Procedimiento inicial para aplicar los estímulos
    initial begin
        // Mostrar un encabezado en la simulación
        $dumpfile("detectar_baterias.vcd");   // Nombre del archivo de señales
        $dumpvars(0, DetectarBateriasDescargada_tb); // Volcar todas las variables del testbench
        $display("Tiempo\tCarga Batería 1\tCarga Batería 2\tAdvertencia Batería 1\tAdvertencia Batería 2");
        $monitor("%0dns\t%b\t\t%b\t\t%b\t\t%b", $time, carga_bateria1, carga_bateria2, advertencia_bateria_1, advertencia_bateria_2);

        // Prueba 1: Ambas baterías tienen carga
        carga_bateria1 = 4'b1010;  // Carga = 10
        carga_bateria2 = 4'b0110;  // Carga = 6
        #10;

        // Prueba 2: Batería 1 descargada, Batería 2 cargada
        carga_bateria1 = 4'b0000;  // Descargada
        carga_bateria2 = 4'b0110;  // Carga = 6
        #10;

        // Prueba 3: Batería 1 cargada, Batería 2 descargada
        carga_bateria1 = 4'b1001;  // Carga = 9
        carga_bateria2 = 4'b0000;  // Descargada
        #10;

        // Prueba 4: Ambas baterías descargadas
        carga_bateria1 = 4'b0000;  // Descargada
        carga_bateria2 = 4'b0000;  // Descargada
        #10;

        // Prueba 5: Ambas baterías completamente cargadas
        carga_bateria1 = 4'b1111;  // Carga máxima
        carga_bateria2 = 4'b1111;  // Carga máxima
        #10;

        // Finalizar la simulación
        $finish;
    end

endmodule
