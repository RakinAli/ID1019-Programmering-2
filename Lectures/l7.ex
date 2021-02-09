defmodule Cards do

  


  def test() do

   deck =[ {:card,:heart,5},
      {:card,:heart,7},
      {:card,:spade,2},
      {:card,:club,9},
      {:card,:diamond,4}
    ]
    sort(deck)
  end


  def lt({:cards,s,v1},{:card,s,v2}) do
    v1<v2
  end

  def lt({:card,:club,_},_) do
    true
  end

  def lt({:card,:diamond,_},{:card,:heart,_}) do
    true
  end

  def lt({:card,:diamond,_},{:card,:spade,_}) do
    true
  end

  def lt({:card,:heart,_},{:card,:spade,_}) do
    true
  end

  #If there's nothing to sort
  def sort([]) do
    []
  end

  #If there's only one element
  def sort([n])do
    [n]
  end

  #If we send in a list that needs to be sorted
  def sort(list) do
    {a,b} = split(list)
    merge(sort(a),sort(b))
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


  def split([]) do
    {[],[]}
  end

  #If we only have one card
  def split([c]) do
    {[c],[]}
  end

  def split([c1,c2|t]) do
    {s1,s2} = split(t)
    {[c1|s1],[c2|s2]}
  end

  def split(list) do
    split(list,[],[])
  end

  def split([],a,b) do
    {a,b}
  end

  def split([h|t],a,b) do
    split(t,b,[h|a])
  end




end
