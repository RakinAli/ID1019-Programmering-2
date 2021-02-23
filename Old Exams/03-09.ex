defmodule Q1 do
    #Question 1
  #-> The toggle function should take a list and return a list
  # where the elements have switches places. If the totala amount of elements
  # is an odd number then the last one is left on its place

  #Case 1 -> If we have an empty list thrown in
  def toggle([]) do
    toggle([],[])
  end

  #Case 2 -> If we have a list thrown then when switch places
  def toggle(list) do
    toggle(list,[])
  end

  #Case 3 -> Empty case
  def toggle([],[]) do
    []
  end

  #Case 4 -> Base case
  def toggle([],list) do
    list
  end

  #Starting case
  def toggle([h1,h2|t],[]) do
    toggle(t,[h2,h1])
  end

  #Running case
  def toggle([h1,h2|t],list) do
    toggle(t,list++[h2,h1])
  end

  #
  def toggle([h],list) do
    list++[h]
  end

  # Without accumelator
  def toggla([h1,h2|t]) do
    [h2,h1 | toggla(t)]
  end

  #Base case
  def toggla([]) do
    []
  end

  #Ending case -> When we come to 1 then we leave it
  def toggla(element) do
    element
  end

end

defmodule Q2 do
  #Implement a stack: Suggest a suitable datastructure and implement
  #the functions push/2 and pop/1. The funktion push/2 shall return the
  #uppdated stack and pop shall return either {ok,any(),stack()} if theres
  #an element on the stack or :no if the stack is empty

  @type stack() :: [any()]

  def pop([]) do
    :no
  end

  def pop([h|t]) do
    stack = t
    {:ok,h,stack}
  end

  def push(element,stack) do
    [element]++stack
  end
end

defmodule Q3 do

  # A function that "adds" a list of lists]
  def flatten([]) do
    []
  end

  #
  def flatten([h|t]) do
    flatten(h) ++ flatten(t)
  end

  #Base case
  def flatten(element) do
    [element]
  end

  def test() do
    flatten([1,[2],[[3,[4,5]], 6]])
  end


end
