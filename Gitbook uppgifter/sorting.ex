defmodule Test do

  @doc """
  Think of two mayor cases, what to do if the list is empty and what
  to do if the contains at least one element. Assume that the elemnets
  are integers and can be compared used the regular >,<,= operator
  """

  #-> Inserts into an empty list
  def insert(a,[]) do
    [a]
  end

  #-> 2 Cases. Either behind or in front of header Recursively
  def insert(a,[h|t]) do
    if a>h do
      [h|insert(a,t)]
    else
      [a,h|t]
    end
  end

  def isort(list) do
    [] -> "Nothing"
    [h|t] -> 
  end


end
