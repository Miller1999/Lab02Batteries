
module CargaCritica(
    input[3:0] carga_bateria1,
    input[3:0] carga_bateria2,
    output advertencia_critica
);
    wire [4:0] carga_total;
    SumaCarga FA(
        .carga_bateria1(carga_bateria1),
        .carga_bateria2(carga_bateria2),
        .carga_total(carga_total)
    );

    assign advertencia_critica = (carga_total <= 5'b00011);

endmodule