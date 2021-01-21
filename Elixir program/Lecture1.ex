defmodule Test do
  def sum(x) do
    case x do
      {} -> 0
      {a} ->a
      {a,b} -> a+b
      {a,b,c} -> a+b+c
      {a,b,c,d} -> a+b+c+d
      _ -> "Not possible"
    end
  end

  def age(x) do
    case x do
      {:person,a,_} -> a
      _ -> :error
    end
  end
end
