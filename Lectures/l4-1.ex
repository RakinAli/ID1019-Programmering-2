defmodule Lst do

  #Adds an tuple to a list- Base case
  def append(:nil,y) do
    y
  end

  #Recursive Case
  def append({:cons,head,tail},y) do
    {:cons,head,append(tail,y)}
  end
end
