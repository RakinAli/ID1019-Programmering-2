defmodule Test do

  @doc """
  Think of two mayor cases, what to do if the list is empty and what
  to do if the contains at least one element. Assume that the elemnets
  are integers and can be compared used the regular >,<,= operator
  """

#___________________________________ INSERTION SORT _________________________________
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

  #_______________________________MERGE SORT_______________________________
  def msort([]) do
    []
  end

  def msort([x]) do
    [x]
  end

  def msort(lst)do
    {l1,l2} = msplit(lst,[],[])
    merge(msort(l1),msort(l2))
  end

  #Empty case right hand side
  def merge(l1,[]) do
    l1
  end

  #Empty case left hand side
  def merge([],l2)do
    l2
  end

  #Compare the heads of the lists
  def merge([h1|t1], [h2|t2]) do
    if h1<h2 do
      [h1] ++ merge(t1,[h2|t2])
    else
      [h2] ++ merge([h1|t1],t2)
    end
  end

  #Base case
  def msplit([],l1,l2) do
    {l1,l2}
  end

  #Splits a list into two lists. List 1 and List 2 receieves an element each
  # time from the lists until the main list is empty
  def msplit([h|t],l1,l2) do
    msplit(t,[h|l2],l1)
  end

  #_____________________ QUICK SORT ____________________

  @doc """
  The quicksort algorithm sounds even quicker than merge sort but this is not true. The idea
  is similar to but now we "do our sorting on the way down". First split the list into two parts,
  one containing low elements and one containing high elments. Then sort the two lists and when
  you're done append the results

  Splitting the lists is done using the first element in the list as a pivot element, all smaller or
  equal than this is added in one list and all larger in one list. When you're appending the final
  result, remember to put the pivot element in the middle
  """

  def qsort([]) do
    []
  end

  def qsplit



  def append([],[]) do

  end

end
