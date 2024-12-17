# Lab 02 - Medidor de carga - Banco de baterias

## Integrantes

- Miller Javier Arias Quintero
- Juan Pablo Ruiz Sabogal
- Daniel Santiago Navarro Gil

## Tabla de contenidos

- [Lab 02 - Medidor de carga - Banco de baterias](#lab-02---medidor-de-carga---banco-de-baterias)
  - [Integrantes](#integrantes)
  - [Tabla de contenidos](#tabla-de-contenidos)
  - [Diseño implementado](#diseño-implementado)
    - [Descripción](#descripción)
    - [Diagramas](#diagramas)
  - [Simulaciones](#simulaciones)
    - [Sumadores](#sumadores)
      - [1Bit](#1bit)
      - [4Bits](#4bits)
    - [Bloque de descarga](#bloque-de-descarga)
    - [Niveles de energia](#niveles-de-energia)
  - [Implementación](#implementación)
  - [Preguntas](#preguntas)
  - [Conclusiones](#conclusiones)
  - [Referencias](#referencias)

## Diseño implementado

### Descripción

Se nos plantea la problemática de la necesidad de implementar un sistema de monioreo que supervise el nivel de carga de un banco de 2 baterias, cada batería cuenta con
un sensor de tensión que convierte valores decimales de 0 a 15 a binario según el nivel de carga de cada batería, siendo (0000) completamente descargada (0 en decimal) y (1111) completamente
cargada (15 en decimal).

### Diagramas

## Simulaciones

### Sumadores

#### 1Bit

![1Bit](/src/assets/simulations/suma_1_bit.png)

#### 4Bits

![Suma Carga](/src/assets/simulations/suma_carga.png)

### Bloque de descarga

![Descarga de Bateria](/src/assets/simulations/bateria_descargada.png)

### Niveles de energia

## Implementación

## Preguntas

1. ¿Qué desafíos pueden surgir al implementar en *hardware* un diseño que funcionaba correctamente en simulación?
   
En primera instancia en este caso particular se presentó la problemática de la lógica negada presente en el Cyclone IV, la cual invertía los bits, haciendo que en la práctica obtuvieramos justamente lo contrario a las simulaciones.
Por otro lado, no presentamos más inconvenientes para el diseño de esta práctica, pero a la hora de manejar circuitos eléctricos es muy común que obtengamos resultados distintos entre simulación e implementación, esto es debido a varios factores
obviando erroes cometidos por manipulación del circuito.

El primer factor son cuestiones ambientales como la temperatura la cual puede afectar la corriente dado que puede variar la resistencia de algunos elementos. 

Por otro lado podemos tener en cuenta factores inevitables como los modelos de los elementos. Los elementos usados académicamente tienden a tener valores característicos significativamente variables entre si y también respecto a los modelos
que podemos usar en los simuladores, restando precisión en la realidad.

2.. Describa el enfoque estructural y comportamental en el contexto de electrónica digital y cómo los implementó en el reto. ¿Qué hace Quartus con cada uno?

3.. ¿Cómo afecta el diseño del sumador y de comparadores al uso de recursos en la FPGA (LUTs, FFs, BRAMs, etc.)? Muestren el uso de recursos de su diseño.

4. ¿Qué impacto tiene aumentar el número de bits de la lectura de cada batería? ¿Qué impacto tiene aumentar el número de baterias del banco? 

5. Describa las diferencias entre los tipos de dato ```wire``` y  ```reg``` en Verilog y compare ambos con el tipo de dato ```logic``` en System Verilog.

6. Únicamente con lo que se vio en clase, describa cómo se usó el bloque ```always```. Enfoque su respuesta hacia la implementación de lógica combinacional.

## Conclusiones

## Referencias
