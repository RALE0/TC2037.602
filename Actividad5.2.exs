# David Vieyra A01656030
# Daniel Rodriguez A01781933

defmodule Hw.Primes do

  #Funcion para sumar los numeros primos de un rango de 1 a finish
  def sum_primes(finish) do
    primes = 1..finish |> Enum.filter(&is_prime/1)
    Enum.sum(primes)
    |> IO.inspect()
  end

  #Funcion para saber si un numero es primo
  defp is_prime(n) when n < 2, do: false
  defp is_prime(2), do: true
  defp is_prime(n) do
    divisors = for i <- 2..trunc(:math.ceil(:math.sqrt(n))), rem(n, i) == 0, do: i
    Enum.empty?(divisors)
  end

  #Funcion para sumar los numeros primos de un rango de manera paralela
  def sum_primes_parallel(finish, num_threads) do
    divide_range(finish, num_threads)
    |> Enum.map(&Task.async(fn -> sum_primes_parallel_helper(&1) end))
    |> Enum.map(&Task.await(&1,10000))
    |> Enum.sum()
    |> IO.inspect()
  end

  #Funcion para sumar los numeros primos de un rango
  defp sum_primes_parallel_helper({start, finish}) do
    primes = (start..finish) |> Enum.filter(&is_prime/1)
    Enum.sum(primes)
  end

  #Funcion para dividir el rango de numeros en partes iguales
  def divide_range(finish, num_threads) do
    updated_num_threads = if finish < num_threads, do: div(finish, 2), else: num_threads
    chunk_size = div(finish, updated_num_threads)
    remainder = rem(finish, updated_num_threads)
    Enum.map(0..(updated_num_threads - 1), fn i ->
      start = i * chunk_size + 1
      stop = if i == (updated_num_threads - 1), do: (i + 1) * chunk_size + remainder, else: (i + 1) * chunk_size
      {start, stop}
    end)
    |> IO.inspect()
  end

  #Funciones para medir el tiempo de ejecucion de los programas
  def timed_sum_primes(finish) do
    start_time = :timer.tc(fn -> sum_primes(finish) end)
    {elapsed_time, _result} = start_time
    IO.puts("Elapsed time: #{elapsed_time} microseconds")
  end

  def timed_sum_primes_parallel(finish, num_threads) do
    start_time = :timer.tc(fn -> sum_primes_parallel(finish, num_threads) end)
    {elapsed_time, _result} = start_time
    IO.puts("Elapsed time: #{elapsed_time} microseconds")
  end

end

# Comandos para correr el programa
#Hw.Primes.sum_primes_parallel(5000000, 14)
#Hw.Primes.sum_primes(5000000)

# Comandos para correr el programa con el tiempo
#Hw.Primes.timed_sum_primes_parallel(5000000, 14)
#Hw.Primes.timed_sum_primes(5000000)
