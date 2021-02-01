defmodule Recursion do

  #Does product by recursion. Hard to fix with case
  def prod(m,n) do
    if m == 0 do
      0
    else
      if m<0 do
        prod(m+1,n) - n
      else
        prod(m-1,n) +n
      end
    end
  end

  #Deals with Fibonnacci
  def fib(x) do
    case x do
      0 -> 0
      1 -> 1
      _ -> fib(x-1) + fib(x-2)
    end
  end

  #Exponents
  def power(number,exponent) do
    if exponent == 0 do
      1
    end

    if exponent == 1 do
      number
    else
      (prod(number,number) * power(number,exponent-1))/number
    end
  end

  #Does Ackerman function
  def ackerman(m,n) do
    cond do
      m==0 -> n+1
      m>0 and n==0 -> ackerman(m-1,1)
      m>0 and n>0 -> ackerman(m-1,ackerman(m,n-1))
    end
  end
end
