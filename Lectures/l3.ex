defmodule Mset do

  def union([],y) do
    y
  end
  def union([h|t],y) do
    z = union(t,y)
    [h|z]
  end

  #Union without messing with the stack space
  def tailr([],y) do
    y
  end
  def tailr([h|t],y) do
    z=[h|y]
    tailr(t,z)
  end

  #Sum recursively
  def sum([]) do
    0
  end
  def sum([n|t]) do
    n + sum(t)
  end

  # Function sum that doesn't take use too much stack space
  def sam(lst) do
    sam(lst,0)
  end
  def sam([],s) do
    s
  end
  def sam([n|t],s)do
    sam(t,n+s)
  end


end
