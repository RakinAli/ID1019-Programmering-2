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


  
end
