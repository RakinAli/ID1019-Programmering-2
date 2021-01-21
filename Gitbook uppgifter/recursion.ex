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
end
