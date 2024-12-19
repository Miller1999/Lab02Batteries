`include "src/DetectarBateriasDescargadas.v"
`include "src/NivelesCarga.v"

module MonitorizacionBateria (
    input [3:0] carga_bateria1,
    input [3:0] carga_bateria2,
    output advertencia_bateria_1,
    output advertencia_bateria_2,
    output optimo,
    output aceptable,
    output regular,
    output critico
);

    // Conexiones internas
    wire [4:0] carga_total;

    // Instancia del módulo DetectarBateriasDescargada
    DetectarBateriasDescargadas detectar_inst (
        .carga_bateria1(carga_bateria1),
        .carga_bateria2(carga_bateria2),
        .advertencia_bateria_1(advertencia_bateria_1),
        .advertencia_bateria_2(advertencia_bateria_2)
    );

    // Instancia del módulo NivelesCarga
    NivelesCarga niveles_inst (
        .carga_bateria1(carga_bateria1),
        .carga_bateria2(carga_bateria2),
        .optimo(optimo),
        .aceptable(aceptable),
        .regular(regular),
        .critico(critico)
    );

endmodule