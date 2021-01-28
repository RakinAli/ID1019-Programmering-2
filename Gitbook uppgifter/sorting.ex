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

  #Insertion sort -> Hard coded but works
  def isort(list) do
    isort(list,[])
  end

  # Starting case - Empty sorted list
  def isort([h|t],[]) do
    isort(t,insert(h,[]))
  end

  # Normal case -> Isort t and sort h into sorted list
  def isort([h|t],list) do
    isort(t,insert(h,list))
  end

  #Ending case -> Return the sorted list
  def isort([],list) do
    list
  end
end
