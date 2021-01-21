defmodule Recursion do

@doc """
Compute the product between n and m

product of n and m:
  if n is 0
  then ...
  otherwise
    the result...
"""

def prod(m,n) do
  case m do
    0 -> 0
    1 -> n
    _ -> prod(m-1,n) + n
  end


  end

end
