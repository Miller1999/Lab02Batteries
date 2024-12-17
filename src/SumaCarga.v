`include "src/Sumador1Bit.v"

module SumaCarga (
    input [3:0] carga_bateria1,  
    input [3:0] carga_bateria2,  
    output [4:0] carga_total
);

    wire C1, C2, C3, C4;

    Sumador1Bit FA0 (
        .A(carga_bateria1[0]),
        .B(carga_bateria2[0]),
        .Cin(1'b0),            
        .S(carga_total[0]),
        .Cout(C1)
    );

    Sumador1Bit FA1 (
        .A(carga_bateria1[1]),
        .B(carga_bateria2[1]),
        .Cin(C1),
        .S(carga_total[1]),
        .Cout(C2)
    );

    Sumador1Bit FA2 (
        .A(carga_bateria1[2]),
        .B(carga_bateria2[2]),
        .Cin(C2),
        .S(carga_total[2]),
        .Cout(C3)
    );

    Sumador1Bit FA3 (
        .A(carga_bateria1[3]),
        .B(carga_bateria2[3]),
        .Cin(C3),
        .S(carga_total[3]),
        .Cout(C4)
    );

    assign carga_total[4] = C4;

endmodule
