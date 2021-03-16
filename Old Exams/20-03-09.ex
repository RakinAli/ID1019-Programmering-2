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

  #Base case
  def flatten([]) do
    []
  end

  #Running case
  def flatten([h|t]) do
    flatten(h) ++ flatten(t)
  end

  #One element case
  def flatten(element) do
    [element]
  end

  def test() do
    flatten([1,[2],[[3,[4,5]], 6]])
  end
end

defmodule Q4 do

  #Tar emot en lista som är ordnad med längsta sträckorna först
  def index([]) do
    "No data"
  end

  #Ropa på en acc
  def index(runs) do
    index(runs,0)
  end

  #
  def index([h|t],index)do
    if(h>index) do
      index(t,index+1)
    else
      index
    end
  end

  def test() do
    index([12,10,8,8,6,4,4,4,2])
  end
end

defmodule Q5 do
  @type tree() :: nil |{:node,tree(),tree()} | {:leaf,any()}

  #Base case 1 -> if there's nill then do nil
  def compact(nil) do
    :nil
  end

  #Base case 2 -> If there's a leaf then just return it untouched
  def compact({:leaf,value}) do
    {:leaf,value}
  end

  #Base case 3 -> If there's a node with two leafs with the same value then compact them
  def compact({:node,{:leaf,value},{:leaf,value}}) do
    {:leaf,value}
  end

  #Running case -> We make the left & right side more compact and combine them
  def compact({:node,left,right}) do
    compactLeft = compact(left)
    compactRight = compact(right)
    combine(compactLeft,compactRight)
  end

  #
  def combine({:leaf,value},nil) do
    {:leaf,value}
  end

  def combine(nil,{:leaf,value}) do
    {:leaf,value}
  end

  def combine(left,right) do
    {:node,left,right}
  end

  def test1() do
    compact({:node, {:leaf, 4}, {:leaf, 4}})
  end

  def test2() do
    compact({:node, {:leaf, 5}, {:node, :nil, {:leaf, 4}}})
  end

end

defmodule Q7 do

  @type next() :: {:ok,integer,(->next())}

  #Finds primes numbers
  def primes() do
    fn()->{:ok,2,fn()->sieve(2,fn()->next(3)end)end} end
  end

  #Iterates to the next number +1
  def next(n) do
    {:ok,n,fn->next(n+1)end}
  end

  def sieve(p, f) do
    {:ok, n, f} = f.()
    if rem(n, p) == 0 do
       sieve(p, f)
    else
      #We iterates to the next prime number
      {:ok, n, fn() -> sieve(n, fn() -> sieve(p, f) end) end}
    end
  end
end


