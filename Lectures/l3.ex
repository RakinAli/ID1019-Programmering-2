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

  def odd([]) do
    []
  end

  #Saves the odds numbers
  def odd([h|t]) do
    if rem(h,2) == 1 do
      [h|odd(t)]
    else
      odd(t)
    end
  end

  def even([]) do
    []
  end

  def even([h|t]) do
    if rem(h,2) == 0 do
      [h|even(t)]
    else
      even(t)
    end
  end

  def odd_n_even(lst) do
    o = odd(lst)
    e = even(lst)
    {o,e}
  end

  def add_n_even(lst) do
    add_n_even(lst, [],[])
  end

  def add_n_even([],odd,even) do
    {odd,even}
  end

  def add_n_even([h|t],odd,even) do
    if rem(h,2) == 1 do
      add_n_even(t,[h|odd],even)
    else
      add_n_even(t,odd,[h|even])
    end
  end

  # Reverse function - Uses the stack
  def rev([]) do
    []
  end
  def rev([h|t]) do
    res = rev(t)
    res ++[h]
  end

  #Optimize Reverse function
  def rav(lst) do
    rav(lst,[])
  end

  def rav([],res) do
    res
  end

  def rav([h|t],res) do
    rav(t,[h|res])
  end

  # A function that "adds" a list of lists]
  def flat([]) do
    []
  end

  def flat([l|t]) do
    l ++ flat(t)
  end


  # Adds a lists of list together
  def flut(lst) do
    flut(lst,[])
  end

  #Base case - If the list is empty just call res
  def flut([],res) do
    res
  end

  #Not empty list -
  def flut([l|t], res) do
    flut(t,res ++ l)
  end
end
