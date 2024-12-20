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
      - [Caja Negra](#caja-negra)
      - [Caja Blanca](#caja-blanca)
      - [Diagrama de flujo](#diagrama-de-flujo)
  - [Simulaciones](#simulaciones)
    - [Sumadores](#sumadores)
      - [1Bit](#1bit)
      - [4Bits](#4bits)
    - [Bloque de descarga](#bloque-de-descarga)
    - [Niveles de energia](#niveles-de-energia)
    - [Monitorización](#monitorización)
  - [Implementación](#implementación)
  - [Preguntas](#preguntas)
  - [Conclusiones](#conclusiones)
  - [Referencias](#referencias)

## Diseño implementado

### Descripción

Se nos plantea la problemática de la necesidad de implementar un sistema de monioreo que supervise el nivel de carga de un banco de 2 baterias, cada batería cuenta con
un sensor de tensión que convierte valores decimales de 0 a 15 a binario según el nivel de carga de cada batería, siendo (0000) completamente descargada (0 en decimal) y (1111) completamente
cargada (15 en decimal).

Para lo solución de la problemática se postulan los siguientes requisitos:

1. Detección de baterías descargadas: Si una de las baterías tiene una carga de 0 (4'b0000), debe generarse una señal de advertencia para así poderla atender.

2. Aviso de carga crítica: Si la carga total del banco de baterías es igual o menor que el 10% de la carga máxima, se debe activar una señal de advertencia, ya sea visual, auditiva o ambas.

3. Otros niveles de carga: Se debe agregar al sistema otros indicadores para informar niveles de carga de interés, por ejemplo, nivel aceptable, regular y crítico.

4. Implementación modular escalable: El diseño completo debe constar de varios módulos para hacer el sistema escalable y claro, lo que facilitará también su validación y verificación. Cada grupo tendrá la libertad de decidir cómo organizar y conectar los módulos.

Para el primer requisito se crea un modulo cuyo objetivo es el de detectar cuando una batería esta descargada, para esto se crean dos entradas de cuatro bits que representan los niveles de carga obtenidos por el sensor para cada batería y dos salidas que representan
la advertencia cuando se cumple que la carga de alguna batería es 0. Se usa "assign" para definir las salidas como combinacionales lo que quiere decir que estas salidas dependen directamente de la entrada, no hay almacenamiento de datos, por decirlo asi, el procedimiento se realiza en tiempo real a medida que las entradas varían.

Para el segundo requisito se debe activar una señal de alerta cuando la batería total sea igual o menos al 10%, por lo cual es necesario hacer un sumador que sume la carga de cada batería y en base a eso se realiza el procedimiento. Para el modulo del sumador bit a bit recibe tres entradas (A,B y Cin) y tiene dos salidas (S y Cout)

### Diagramas

Se muestran a continuación tres diagramas que muestran el comportamiento del diseño implementado

#### Caja Negra

![Caja Negra](/src/assets/diagrams/CajaNegra.png)

#### Caja Blanca

![Caja Blanca](/src/assets/diagrams/CajaBlanca.png)

#### Diagrama de flujo

![Diagrama de flujo](/src/assets/diagrams/flujo.png)

## Simulaciones

A partir de los archivos verilog se crearon los archivos testbench esto con el fin de probar el funcionamiento de cada modulo y que cada uno de estos cumpla con su proposito.

### Sumadores

Se uso un sumador de 1 bit [Sumador 1 Bit](/src/Sumador1Bit.v) y a partir de la repetida instanciacion de este modulo se crea el sumador de 4 bits, en este caso llamado [Sumador 4 Bits](/src/SumaCarga.v)

#### 1Bit

Con el testbench [Sumador1Bit_tb](/src/Sumador1Bit_tb.v) se puede observar el comportamiento de la suma

![1Bit](/src/assets/simulations/suma_1_bit.png)

#### 4Bits

Con el testbench [SumaCarga_tb](/src/SumaCarga_tb.v) se puede observar el comportamiento de la suma total de las baterias

![Suma Carga](/src/assets/simulations/suma_carga.png)

### Bloque de descarga

Este modulo [Detectar Baterias Descargadas](/src/DetectarBateriasDescargadas.v) se encarga de detectar cuando una batería esta descargada, para esto se desarrollo un testbench que muestre el comportamiento [DetectarBateriasDescargadas_tb](/src/DetectarBateriasDescargadas_tb.v)

![Descarga de Bateria](/src/assets/simulations/bateria_descargada.png)

### Niveles de energia

Por ultimo este modulo [Niveles de Energia](/src/NivelesEnergia.v) se encarga de enviar una alerta sonora y visual dependiendo del nivel de carga, teniendo 4 niveles:

- Nivel Optimo `>75%`
- Nivel Aceptable `50% - 74%`
- Nivel Regular `25% - 49%`
- Nivel Critico `0% - 24%`

Con estos niveles se desarrollo un testbench que muestre el comportamiento [NivelesCarga_tb](/src/NivelesCarga_tb.v)

![Niveles](/src/assets/simulations/niveles_carga.png)

### Monitorización

Finalmente se instancian todos los modulos en un unico archivo llamado [Monitorizacion Bateria](/src/MonitorizacionBateria.v) y se crea un testbench con el mismo nombre. Aqui se ve el funcionamiento completo:

![Monitorizacion](/src/assets/simulations/Monitorizacion.png)

## Implementación

## Preguntas

1. ¿Qué desafíos pueden surgir al implementar en _hardware_ un diseño que funcionaba correctamente en simulación?

En primera instancia en este caso particular se presentó la problemática de la lógica negada presente en el Cyclone IV, la cual invertía los bits, haciendo que en la práctica obtuvieramos justamente lo contrario a las simulaciones.
Por otro lado, no presentamos más inconvenientes para el diseño de esta práctica, pero a la hora de manejar circuitos eléctricos es muy común que obtengamos resultados distintos entre simulación e implementación, esto es debido a varios factores
obviando erroes cometidos por manipulación del circuito.

El primer factor son cuestiones ambientales como la temperatura la cual puede afectar la corriente dado que puede variar la resistencia de algunos elementos.

Por otro lado podemos tener en cuenta factores inevitables como los modelos de los elementos. Los elementos usados académicamente tienden a tener valores característicos significativamente variables entre si y también respecto a los modelos
que podemos usar en los simuladores, restando precisión en la realidad.

2. Describa el enfoque estructural y comportamental en el contexto de electrónica digital y cómo los implementó en el reto. ¿Qué hace Quartus con cada uno?

3. ¿Cómo afecta el diseño del sumador y de comparadores al uso de recursos en la FPGA (LUTs, FFs, BRAMs, etc.)? Muestren el uso de recursos de su diseño.

Estos términos son comunes en la implementación de una FPGA ya que son básicos para el diseño de FPGA, partiendo por los LUTSs que hacen referencia a tablas de consulta (similar a una tabla de verdad), es decir, que combinaciones de entrada generan salidas específicas. Se usa para lógica combinatoria, por ende, podemos aplicarlo en la lógica de un sumador o de comparadores ya que las salidas no dependen del estado previo o del historial del sistema. En nuestro diseño usamos esta herramienta para diseñar el sumador de 1 bit en `Sumador1Bit.v` haciendo operaciones lógicas de suma y acarreo con XOR, AND y OR. De igual manera en `NivelesCarga.V` se usaron para la sección de comparaciones de magnitud entre las cargas totales y asi, devolver un nivel de batería.

Respecto a los FFs (Flip-Flops) a diferencia de los LUTs, son usados para almacenar valores, es decir, siguen la lógica secuencial. En nuestro caso no usamos lógica secuencial ya que el código se puede hacer con lógica combinacional dado que las salidas que obtenemos son en función de entradas en tiempo real, no es de interés valores pasados.

Las BRAM (Block RAM) son un bloque de memoria clave que se suele usar en aplicaciones donde se necesita almacenar gran cantidad de datos que no pueden ser manejados por registros simples. En nuestro caso manejamos entradas de 4 bits, es decir, entradas con poca cantidad de datos, por lo cual no se usa BRAM, pero podría usarse si por ejemplo deseáramos almacenear datos como una tabla de carga total de las baterías en función del tiempo.

4. ¿Qué impacto tiene aumentar el número de bits de la lectura de cada batería? ¿Qué impacto tiene aumentar el número de baterias del banco?

Originalmente tenemos un máximo de 4 bits para la lectura de cada bateria, es decir, un valor máximo de carga de 15 decimal, pero este valor es arbitrario ya que es contraintuitivo hablar de carga de una batería sin usar porcentajes de 0 a 100 como es el estándar,
podríamos asumir que esto se hace para facilitar el análisis, y cada valor obtenido a partir de los 4 bits es una representación de la carga de la batería. En base a lo planteado anteriormente al aumentar el número de bits de la lectura podriamos decir que
no afectaría en nada, ya que simplemente estas lecturas realizadas con más bits implicarían un tipo distinto de relación al que se tenia anteriormente, es decir, si por ejemplo usamos 5 bits, el valor máximo decimal sería 31, que al igual que el 15 con 4 bits, seguiría siendo un valor obtenido del sensor de de tensión que representa un nivel de carga total. Respecto a aumentar el número de baterias del banco afectaría la sección de niveles de batería, ya que ahora el 30 decimal no sería el máximo sino 45,60,75,etc a medida que aumentamos las baterías del banco, lo que tendría que verse reflejado en el código del sistema de monitoreo. En caso que no se realice ningún cambio en el código, el sistema no reaccionará ante los nuevos niveles de batería y solo manejará los originales.

5. Describa las diferencias entre los tipos de dato `wire` y `reg` en Verilog y compare ambos con el tipo de dato `logic` en System Verilog.

Las diferencias entre `wire` y `reg` es que wire se usa para representar conexiones de cableado, es decir, es una representación de cables físicos, no posee la cualidad de almacenar valores y se usa en asignaciones continuas `assign`, por otro lado, `reg` como su nombre lo dice, no es un registro de hardware, representa elementos de almacenamiento de datos, es decir, describe lógica secuencial y se usa en asignaciones procedurales con `always`.

El tipo de dato `logic` unifica `wire` y `reg` eliminando las confusiones para desencadenar un código mas sencillo y robusto. Este tipo de dato permite asignaciones procedurales `always` y continuas `assign`, eliminando las barreras entre `wire` y `reg`, permitiendo almacenamiento y permitiendo describir lógica combinacional
como `wire` pero sin representar puramente un cable físico

6. Únicamente con lo que se vio en clase, describa cómo se usó el bloque `always`. Enfoque su respuesta hacia la implementación de lógica combinacional.

## Conclusiones

## Referencias

- [Sumador](https://github.com/digital-electronics-UNAL/2024-2/blob/main/labs/lab02/sumador.md)
- [Cyclone IV EP4CE10E22C8N](https://www.intel.la/content/www/xl/es/content-details/654630/cyclone-iv-device-handbook-volume-1-chapter-1-fpga-device-family-overview.html)
