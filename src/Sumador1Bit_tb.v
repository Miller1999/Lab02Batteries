`timescale 1ns / 1ps
`include "src/Sumador1Bit.v"

module Sumador1Bit_tb;

    // Entradas del módulo
    reg A;
    reg B;
    reg Cin;

    // Salidas del módulo
    wire S;
    wire Cout;

    // Instancia del módulo bajo prueba (DUT - Device Under Test)
    Sumador1Bit dut (
        .A(A),
        .B(B),
        .Cin(Cin),
        .S(S),
        .Cout(Cout)
    );

    // Proceso de prueba
    initial begin
        // Encabezado en la simulación
        $dumpfile("suma_1_bit.vcd");   // Nombre del archivo de señales
        $dumpvars(0, Sumador1Bit_tb); // Volcar todas las variables del testbench
        $display("Time\tA\tB\tCin\t|\tS\tCout");
        $monitor("%0t\t%b\t%b\t%b\t|\t%b\t%b", $time, A, B, Cin, S, Cout);

        // Prueba de todas las combinaciones posibles
        A = 0; B = 0; Cin = 0; #10;  // Caso 1: 000
        A = 0; B = 0; Cin = 1; #10;  // Caso 2: 001
        A = 0; B = 1; Cin = 0; #10;  // Caso 3: 010
        A = 0; B = 1; Cin = 1; #10;  // Caso 4: 011
        A = 1; B = 0; Cin = 0; #10;  // Caso 5: 100
        A = 1; B = 0; Cin = 1; #10;  // Caso 6: 101
        A = 1; B = 1; Cin = 0; #10;  // Caso 7: 110
        A = 1; B = 1; Cin = 1; #10;  // Caso 8: 111

        // Fin de la simulación
        $finish;
    end

endmodule
