`timescale 1ns / 1ps
`include "src/SumaCarga.v"

module SumaCarga_tb;

    // Declarar señales
    reg [3:0] carga_bateria1;
    reg [3:0] carga_bateria2;
    wire [4:0] carga_total;

    // Instancia del módulo a probar
    SumaCarga uut (
        .carga_bateria1(carga_bateria1),
        .carga_bateria2(carga_bateria2),
        .carga_total(carga_total)
    );

    initial begin
        $dumpfile("suma_carga.vcd");   // Nombre del archivo de señales
        $dumpvars(0, SumaCarga_tb); // Volcar todas las variables del testbench
        // Inicialización
        carga_bateria1 = 4'b0000;
        carga_bateria2 = 4'b0000;

        // Pruebas
        #10 carga_bateria1 = 4'b0011; carga_bateria2 = 4'b0101; // 3 + 5
        #10 carga_bateria1 = 4'b1111; carga_bateria2 = 4'b1111; // 15 + 15
        #10 carga_bateria1 = 4'b0000; carga_bateria2 = 4'b0000; // 0 + 0
        #10 carga_bateria1 = 4'b0111; carga_bateria2 = 4'b1000; // 7 + 8

        #10 $stop;  // Finaliza la simulación
        $finish;
    end

endmodule
