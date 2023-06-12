# David Vieyra A01656030
# Daniel Rodriguez A01781933

defmodule Hw.Primes do

  def sum_primes(finish) do
    primes = 1..finish |> Enum.filter(&is_prime/1)
    Enum.sum(primes)
    |> IO.inspect()
  end

  defp is_prime(n) when n < 2, do: false
  defp is_prime(2), do: true
  defp is_prime(n) do
    divisors = for i <- 2..trunc(:math.ceil(:math.sqrt(n))), rem(n, i) == 0, do: i
    Enum.empty?(divisors)
  end

  def sum_primes_parallel(finish, num_threads) do
    divide_range(finish, num_threads)
    |> Enum.map(&Task.async(fn -> sum_primes_parallel_helper(&1) end))
    |> Enum.map(&Task.await(&1,10000))
    |> Enum.sum()
    |> IO.inspect()
  end

  defp sum_primes_parallel_helper({start, finish}) do
    primes = (start..finish) |> Enum.filter(&is_prime/1)
    Enum.sum(primes)
  end

  def divide_range(finish, num_threads) do
    chunk_size = div(finish, num_threads)
    remainder = rem(finish, num_threads)
    Enum.map(0..(num_threads - 1), fn i ->
      start = i * chunk_size + 1
      stop = if i == (num_threads - 1), do: (i + 1) * chunk_size + remainder, else: (i + 1) * chunk_size
      {start, stop}
    end)
    |> IO.inspect()
  end

end

# start_time = :timer.tc(fn -> Hw.Primes.sum_primes_parallel(5000000, 14) end)
# {elapsed_time, _result} = start_time
# IO.puts("Elapsed time: #{elapsed_time} microseconds")


start_time = :timer.tc(fn -> Hw.Primes.sum_primes(5000000) end)
{elapsed_time, _result} = start_time
IO.puts("Elapsed time: #{elapsed_time} microseconds")


#Hw.Primes.sum_primes_parallel(5000000, 14)
#Hw.Primes.sum_primes(5000000)
