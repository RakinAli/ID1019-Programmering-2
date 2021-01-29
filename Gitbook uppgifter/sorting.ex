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
  @doc """
  In Merge Sort, you divide the list into two list. Then you merge sort each of
  these lists to obtain two sorted sub-lists. These sorted sub-lists are then merged
  into one final sorted list.

  The two lists are merged by picking the smallest of the elements from each of the lists
  Since each list is sorted, one need only to look at the first element of each list to determine
  which element is the smallest.
  """

  def msplit([],[],[]) do
    []
  end

  def msplit([],[],[])


end
