defmodule Q1 do

  @doc """
  Implementera en funktion, drop/2 som tar en lista och ett tal n > 0 , och
  returnerar en lista där var n:te element har plockats bort.
  """

  #Anta att n> 0

  #Base case callee
  def drop([],n) do
    drop([],n,n)
  end

  #Calee case
  def drop(lst,n)do
    drop(lst,n,n)
  end

  #Base case
  def drop([],_,_) do
    []
  end

  #Drops the element if n = 1
  def drop([_|rest],1,n) do
    drop(rest,n,n)
  end

  #Iteratres untill n = 1
  def drop([elem|rest],i,n) do
    [elem|drop(rest,i-1,n)]
  end
end

defmodule Q2 do

  #Base case -> empty list
  def rotate([],_)do
    []
  end

  def rotate(lst,0) do
    lst
  end

  def rotate([h|t],n) do
    list = t ++ [h]
    rotate(list,n-1)
  end
end

defmodule Q3 do
  @doc """
  Implementera en funktion nth/n som hittar värdet i det n'te lövet i ett binärt träd
  traverserat djupet först vänster till höger. Funktionen skall ta ett tal n>0 och ett binärt
  träd och returnera antingen:
  *{found,val} om n'te lövet hittas och har värdet val eller
  * {:cont, k} om endast n-k löv hittades dvs man skulle behöva k fler löv att hitta det n'te

  OBS! Du skall inte transformera hela trädet till en lista och sedan hitta det n'te lövet. Du skall hitta
  hitta lövet geno matt raversa trädet och stanna så snart du hittar det n'te lövet.

  Träden är representerade enligt följande, notera att det inte finns något tomt träd
  och att vi endast har värden i löftne
  """

  @type tree() :: {:leaf,any()} |{:node,tree(),tree()}

  #Base case1-> Leaf and we have 1
  def nth({:leaf,item},1) do
    {:found,item}
  end

  #Base case2  -> Leaf and n>1 then we return cont n-1
  def nth({:leaf,_},n) do
    {:cont,n-1}
  end

  def nth({:node,left,right},n) do
    case nth(left,n) do
      #If we find the node then we good
      {:found,item}-> {:found,item}
      #If not we go right
      {:cont,k} -> nth(right,k)
    end
  end

  def test1() do
    #Checks base case 1 -> If we find a first item
    nth({:leaf,:dinMamma},1)
  end

  def test2() do
    #Check base case 2 -> We are gonna return {cont,n-1}
    nth({:leaf,:dinPappa},2)
  end

  def test3() do
    nth({:node,  {:node,   {:leaf, :a},
                              {:leaf, :b}},
                    {:leaf, :c}},3)

  end
end

defmodule Q4 do

  @type op() :: :add|:sub
  @type instruc() :: integer() | op()
  @type seq() :: [instruc()]

  @spec hp35(seq()) :: integer()

  def hp35([]) do
    "No instructions"
  end

  def hp35(lst) do
    stack(lst,[])
  end

  #Base case ->
  def stack([],[rest|_]) do
    rest
  end

  #Addition
  def stack([:add|rest],[a, b|stackk]) do
    stack(rest,[a+b|stackk])
  end

  #Subtraction
  def stack([:sub|rest],[a, b |stackk]) do
    stack(rest,[b-a|stackk])
  end

  #Add to the stack
  def stack([useless|rest],stackk) do
    stack(rest,[useless|stackk])
  end

  def test() do
    hp35([3, 4, :add, 2, :sub])
  end
end

defmodule Q5 do

  @moduledoc """
  The logic is simple. Say if we take row n and pick element k. What we do is we take (n-1/k-1) + (n-1/k) = (n/k) for each and every element
  """

  #Base case
  def pascal(1) do
    [1]
  end

  #Running case
  def pascal(n) do
    [1|next(pascal(n-1))]
  end

  #B
  def next([1]) do
    [1]
  end

  def next([h|t]) do
    [before|_] = t
    [h+before|next(t)]
  end
end

defmodule Q7 do
  
end
