defmodule Fib do


  def sequential(n) do
    {t,f} = :timer.tc(fn()-> seq(n)end)
    IO.puts("Sequential fib(#{n}) = #{f} in #{trunc(t/1000)} ms")
    :ok
  end

  def parallel(n) do
    {t,f} = :timer.tc(fn()->par(n)end)
    IO.puts("Parallel fib(#{n})= #{f} in #{trunc(t/1000)} ms  ")
  end

  def seq(0) do
    1
  end

  def seq(1) do
    1
  end

  def seq(n) do
    seq(n-1) + seq(n-2)
  end

  def par(0) do
    1
  end

  def par(1) do
    1
  end

  def par(n) do
    r1 = paral(fn()-> par(n-1)end)
    r2 = paral(fn()->par(n-2)end)
    f1 = collect(r1)
    f2 = collect(r2)
    f1+f2
  end

  def paral(f) do
    ref = make_ref()
    me = self()
    spawn(fn()-> send(me,{:par,ref,f.()})end)
    ref
  end

  def collect(ref) do
    receive do
      {:par,^ref,rest} -> rest
    end
  end


  def comb(0,_) do
    0
  end

  def comb(1,_) do
    1
  end

  def comb(n,k) when n>k do
    r1 = paral(fn()->comb(n-1,k)end)
    r2 = paral(fn()->comb(n-2,k)end)
    f1 = collect(r1)
    f2 = collect(r2)
    f1+f2
  end

  def comb(n,_) do
    1
  end






end
