`include "src/SumaCarga.v"

module NivelesCarga (
    input [3:0] carga_bateria1,
    input [3:0] carga_bateria2,
    output optimo,
    output aceptable,
    output regular,
    output critico
);
    wire [4:0] carga_total;
    wire [4:0] max_carga = 5'd30; // Tamaño máximo de la batería (puedes ajustar según el sistema).

    // Instancia para calcular la suma de las cargas
    SumaCarga CargaTotal(
        .carga_bateria1(carga_bateria1),
        .carga_bateria2(carga_bateria2),
        .carga_total(carga_total)
    );

    // Calcula los niveles en función del porcentaje del tamaño máximo de la batería
    wire [4:0] umbral_optimo = (max_carga * 75) / 100; // 75% del máximo
    wire [4:0] umbral_aceptable = (max_carga * 50) / 100; // 50% del máximo
    wire [4:0] umbral_regular = (max_carga * 25) / 100; // 25% del máximo
    wire [4:0] umbral_critico = (max_carga * 10) / 100; // 10% del máximo

    assign optimo = (carga_total >= umbral_optimo);
    assign aceptable = (carga_total >= umbral_aceptable) && (carga_total < umbral_optimo);
    assign regular = (carga_total >= umbral_regular) && (carga_total < umbral_aceptable);
    assign critico = (carga_total < umbral_regular);


endmodule
