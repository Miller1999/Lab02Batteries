module DetectarBateriasDescargadas(
    input[3:0] carga_bateria1,
    input[3:0] carga_bateria2,
    output advertencia_bateria_1,
    output advertencia_bateria_2
);

    assign advertencia_bateria_1 = (~ carga_bateria1[0] & ~ carga_bateria1[1] & ~ carga_bateria1[2] & ~ carga_bateria1[3]);
    assign advertencia_bateria_2 = (~ carga_bateria2[0] & ~ carga_bateria2[1] & ~ carga_bateria2[2] & ~ carga_bateria2[3]);
    
endmodule