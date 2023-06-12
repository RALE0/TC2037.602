# TC2037.602
Implementación de métodos computacionales

David Vieyra A01656030 
Daniel Rodríguez A01781933

# Reporte de Resultados

Fecha: 11 de junio de 2023

En este documento se presentan los resultados obtenidos al comparar el rendimiento de dos funciones: `sum_primes` y `sum_primes_parallel`. Ambas funciones calculan la suma de todos los números primos menores a un límite dado.

## 1. Función sum_primes

La función `sum_primes(5000000)` se implementó de manera convencional, realizando el cálculo de manera secuencial. El lapso de tiempo medido para esta implementación fue de 96,215,654 microsegundos.

## 2. Función sum_primes_parallel

La función `sum_primes_parallel(5000000, 14)` se desarrolló utilizando un enfoque paralelo para realizar los cálculos. Esta implementación distribuye la carga de trabajo entre 14 hilos de ejecución simultáneos. El lapso de tiempo medido para esta implementación paralela fue de 13,912,064 microsegundos.

## Resultados

A continuación se presenta un resumen de los resultados obtenidos:

- `sum_primes(5000000)`:
   - Tiempo medido: 96,215,654 microsegundos.
   - Convertido a segundos: 96.215654 segundos.

- `sum_primes_parallel(5000000, 14)`:
   - Tiempo medido: 13,912,064 microsegundos.
   - Convertido a segundos: 13.912064 segundos.

## Cálculo del Speedup

El speedup se calcula dividiendo el tiempo de ejecución secuencial entre el tiempo de ejecución paralelo:

Speedup = Tiempo de ejecución secuencial / Tiempo de ejecución paralelo

Utilizando los datos obtenidos:

Speedup = 96.215654 segundos / 13.912064 segundos

El speedup calculado es aproximadamente 6.92.

## Conclusión

Comparando ambos enfoques de implementación, se observa que la versión paralela (`sum_primes_parallel`) logró reducir significativamente el tiempo de ejecución en comparación con la implementación convencional (`sum_primes`). Esta mejora se debe a la capacidad de realizar cálculos simultáneos utilizando múltiples hilos de ejecución.

El speedup obtenido de 6.92 indica que la implementación paralela es aproximadamente 6.92 veces más rápida que la implementación secuencial.

Se recomienda utilizar la función `sum_primes_parallel` en escenarios donde el rendimiento y la eficiencia son aspectos críticos, ya que puede aprovechar los recursos de procesamiento de manera más efectiva.
