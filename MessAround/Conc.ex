defmodule Conc do

  def acc(saldo) do
    receive do
      #If we
      {:deposit,money} ->
        acc(saldo+money)
      {:withdraw,money} ->
        acc(saldo-money)
      {:request,from} ->
        send(from,{:saldo,saldo})
        acc(saldo)
    end
  end

  #Spawns a process
  def doit() do
    #Spawns a process and binds it to acc
    acc = spawn(fn() -> acc(0) end)
    send(acc,{:deposit,20})
    send(acc,{:withdraw,10})
    #Returns the process
    acc
  end

  def check(acc) do
    send(acc,{:request,self()})
    receive do
      {:saldo,saldo} ->
        saldo
    end
  end
end
