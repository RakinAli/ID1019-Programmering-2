defmodule Lists do

  #Tak takes an argument and reutnrs the first element of a list
  def tak([]) do
    "Empty list"
  end

  def tak([h|_]) do
    h
  end

  #Deletes the header and returns the tail of the list
  def drp([]) do
    "Nothing to delete"
  end

  def drp([_|t]) do
    t
  end


  #Len -> returns the length of the list
  def len([]) do
    len([],0)
  end

  def len([h|t]) do
    len([h|t],0)
  end

  def len([],n) do
    n
  end

  def len([_|t],n) do
    len(t,n+1)
  end

  #Sum -> Returns the sum of the list
  def sum(lst) do
    sum(lst,0)
  end

  def sum([],s) do
    s
  end

  def sum([n|t],s) do
    sum(t,n+s)
  end

  #Duplicates -> Returns a list where all elements are duplicated
  def duplicate([]) do
    []
  end

  def duplicate([h|t]) do
    [h,h|duplicate(t)]
  end

  #Add -> Add the elemt X to the list if it is not in the list
  def add(x,[]) do
    [x]
  end

  def add(x,[h|t]) do
    if h != x do
      [h|add(x,t)]
    else
      add(x,t)
    end
  end

  #Removes an occurance of a list
  def remove(_,[]) do
    []
  end

  def remove(x,[h|t]) do
    if h != x do
      [h|remove(x,t)]
    else
      remove(x,t)
    end
  end

  #Unique -> Return a list of unique elements in the list
  # Uses add to

  def unique([]) do
    unique([],[])
  end

  def unique(lst) do
    unique(lst,[])
  end

  def unique([],[]) do
    []
  end

  def unique([],[h|t]) do
    [h|t]
  end

  def unique([h|t],[]) do
    unique(t,[h])
  end

  def unique([a|b],[h|t]) do
    if a != h do
      unique(b,add(a,[h|t]))
    else
      unique(b,[h|t])
    end
  end

  #Append -> A function that appends two lists into one list
    # Adds a lists of list together
    def append(lst) do
      append(lst,[])
    end

    #Base case - If the list is empty just call res
    def append([],res) do
      res
    end

    #Not empty list -
    def append([l|t], res) do
      append(t,res ++ l)
    end
end
