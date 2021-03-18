defmodule Q1 do

  #1) -> Becomes 8
  #2) -> Becomes 10
  #3) -> Becomes 12
end

defmodule Q4 do


  def fizzbuzz(n) do
    fizzbuzz(1,n+1,1,1)
  end

  def fizzbuzz(n,n,_,_) do
    []
  end

  #Fizz buzz condiiton
  def fizzbuzz(i,n,3,5) do
    [:fizzbuzz|fizzbuzz(i+1,n,1,1)]
  end

  def fizzbuzz(i,n,3,number) do
    [:fizz|fizzbuzz(i+1,n,1,number+1)]
  end

  def fizzbuzz(i,n,number,5) do
    [:buzz|fizzbuzz(i+1,n,number+1,1)]
  end

  def fizzbuzz(i,n,number1,number2) do
    [i|fizzbuzz(i+1,n,number1+1,number2+1)]
  end
end

defmodule Q5 do

  #fuck tidskomplexitet
end

defmodule Q6 do

  def dillinger() do
    pid1 = spawn(fn()->start()end)
    send(pid1,{:knife})
    send(pid1,{:fork})
    send(pid1,{:bottle})
    send(pid1,{:cork})
  end

  def start() do
    IO.puts("Jim I fucked your wife")
    receive do
      {:knife} ->
        knife()
    end
  end

  def fork() do
    IO.puts("Now I forked your wife")
    receive do
      {:bottle} ->
        bottle()
    end
  end

   def knife() do
    IO.puts("Now I knifed your wife")
    receive do
      {:fork} ->
        fork()
    end
  end

  def bottle do
    IO.puts("Now I bottled your wife")
    receive do
      {:cork} ->
        start()
    end
  end

  def hello() do
    IO.puts("This is the second process")
  end
end

defmodule Q7 do

  def fold() do

  end

  def split([], l1, l2) do
    {l1, l2}
  end

  def split([h|t], l1, l2) do
    split(t, l2, [h|l1])
  end



end
