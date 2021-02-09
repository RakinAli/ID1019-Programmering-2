defmodule High do


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





  def foldr([],acc,_op) do
    acc
  end

  def foldr([h|t],acc,op) do
    op.(h,foldr(t,acc,op))
  end

  def foldl([],acc,_op) do
    acc
  end

  def foldl([h|t],acc,op) do
    foldl(t,op.(h,acc),op)
  end


  #Reverse on out list  -> More effectinve
  def tomat(lst) do
    op = fn(h,a)-> a ++ [h] end
    foldr(lst,[],op)
  end

  # Does reverse on our list - Less effective
  def morot(lst) do
    op = fn(h,a) ->[h|a] end
    foldl(lst,[],op)
  end

  #Gå ner i listan sedan gör vi append lst för varje liten lista vi har haffat på
  # så append right är bättre än append left.
  def append_right(lst) do
    op = fn(e,acc) -> e ++ acc end
    foldr(lst,[],op)
  end

  #Svansrecursivt men det vi gör påvägen ner är vår acc växer hela tiden och
  # i slutnädan har vi en gig acc som vi ska göra append på med sista elelent
  def append_left(lst) do
    op = fn(e,acc) -> acc ++ e end
    foldl(lst,[],op)
  end

  def appendr(l) do
    f = fn(e,a) -> e++a end
    foldr(l,[],f)
  end

  def appendr(l) do
    f = fn(e,a) -> a++e end
    foldl(l,[],f)
  end

  def map([],_op)do
    []
  end

  def map([h|t],op) do
    [op.(h)|map(t,op)]
  end

  def filter([],_) do
    []
  end

  def filter([h|t],op) do
    if op.(h) do
      [h|filter(t,op)]
    else
      filter(t,op)
    end
  end

  def infinity() do
    fn() -> infinity(0) end
  end

  def infinity(n) do
    [n|fn() -> infinity(n+1) end]
  end

  def fib() do
    fn()-> fib(1,1) end

  end

  #Makes Fibonacci
  def fib(f1,f2) do
    [f1|fn()-> fib(f2,f1+f2) end]
  end

  def sumr({:range,from,from}) do
    from
  end

  def sumr({:range,from,to}) do
    from + sumr({:range,from+1,to})
  end

  def sum(range) do
    reduce(range,{:cont,0},fn(x,acc)-> {:cont, x + acc} end)
  end

  def take(range,n) do
    reduce(range,{:cont,{:sofar,0,[]}},
    fn(x,{:sofar,s,acc}) ->
      s= s+1
      if s>= n do
        {:halt,Enum.reverse([x|acc])}
      else
        {:cont,{:sofar,s,[x|acc]}}
      end
    end
    )
  end

  def reduce(range,{:suspend,acc},fun) do
    {:suspended,acc,fn(cmd)->reduce(range,cmd,fun)end}
  end

  def reduce({:range,from,to},{:cont,acc}, function) do
    if from<= to do
      reduce({:range,from+1,to},function.(from,acc),function)
    else
       {:done,acc}
    end
  end

  def reduce(_, {:halt,acc},_) do
    {:halted,acc}
  end

  def head(range) do
    reduce(range,{:cont,:na},
    fn(x,_) ->
      {:suspend,x}
    end)
  end


  def prod(range) do
    reduce(range,{:cont,1},fn(x,acc) -> {:cont, x * acc } end)
  end



end
