defmodule Luhn do

  #Write your personal number except the last number -> This will return
  # your last number

  def start([]) do
    []
  end

  def start(lst)do
    #1,2,3,4-> Takes a list
    #-> Multiply header by 2 then 1 then 2 then 1 etc
    listUpdated = multiplier(lst,[],2,1)
    #5 -> Turns all the numbers into digit
    listt = iterator(listUpdated,[])
    #6 -> Take the sum of the number ->return a digit
    sum = adder(listt,0)

    #7 -> Take the modulo of the sum
    last = rem(sum,10)
    #8 -> 10 - 7
    if last == 0 do
      0
    else
      10- last
    end
  end

  def multiplier([],acc,_,_) do
    acc
  end

  def multiplier([h|t],acc,2,1) do
    multiplier(t,acc++[h*2],1,2)
  end

  def multiplier([h|t],acc,1,2) do
    multiplier(t,acc++[h*1],2,1)
  end

  def iterator([h|t],acc) do
    if h>9 do
      iterator(t,acc ++ Integer.digits(h))
    else
      iterator(t,acc++[h])
    end
  end

  def iterator([],acc) do
    acc
  end

  def adder([h|t],start) do
    adder(t,start+h)
  end

  def adder([],sum) do
    sum
  end
end
