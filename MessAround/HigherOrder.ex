defmodule Cards do

  @type suit :: :spade | :heart | :diamond | :club
  @type card :: {:card,suit() , value}
  @type value :: 2..14

  def test() do
    deck =
      [
        {:card,:heart,5},
        {:card,:heart,7},
        {:card,:spade,2},
        {:card,:club,9},
        {:card,:diamond,4}
      ]
    sort(deck)
  end

  #Spader>Hjärter>Ruot>Klöver

  #Less than function
  def lt({:card,s,v1},{:card,s,v2}) do
    v1<v2
  end

  #Klver är den minsta färgen
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

  def lt({:card,_,_},{:card,_,_}) do
    false
  end

  #We want to sort the cards and we use merge sort

  def merge([],s2) do
    s2
  end

  def merge(s1,[]) do
    s1
  end

  def merge([c1|r1]=s1, [c2|r2]=s2) do
    case lt(c1,c2) do
      true ->
        [c1|merge(r1,s2)]
      false ->
        [c2|merge(s1,r2)]
    end
  end

  @spec sort([card]) :: [card]
  #Empty case
  def sort([]) do
    []
  end

  #base case
  def sort([c]) do
    [c]
  end

  def sort(deck) do
    {d1,d2} = split(deck)
    s1 = sort(d1)
    s2 = sort(d2)
    merge(s1,s2)
  end

  @spec split([card]) :: {[card()],[card()]}

  def split(list) do
    split(list,[],[])
  end

  def split([],a,b) do
    {a,b}
  end

  def split([h|t],a,b) do
    split(t,b,[h|a])
  end

  #Base case
  def splitt([]) do
    {[],[]}
  end

  def splitt([c]) do
    {[c],[]}
  end

  #Else
  def splitt([c1,c2|rest]) do
    {s1,s2} = split(rest)
    {[c1|s1],[c2|s2]}
  end

  #Borde vi implementera en merge som funkar över alla datastrukturer

  def foldr([],acc,_op) do
    acc
  end

  def foldr([h|t],acc,operations) do
    operations.(h,foldr(t,acc,operations))
  end

  def foldl([],acc,_op) do
    acc
  end

  def foldl([h|t],acc,op) do
    foldl(t,op.(h,acc),op)
  end

  #Funktion som användes för att lära mig om closurs
  def foo(x) do
    y = 3
    fn(v)-> v+y+x end
  end

  # Counts length of an list
  def gurka(l) do
    f = fn(_,a)-> a + 1 end
    foldr(l,0,f)
  end

end
