defmodule Q1 do

  def decode(lst) do
    #Calls a helper function
    code(lst,[])
  end

  #Base case -> return the acc
  def code([],lst) do
    lst
  end

  #If frek = zero then continue with tail
  def code([{_,0}|t],lst) do
    code(t,lst)
  end

  #Running case -
  def code([{char,frek}|t],lst) do
    code([{char,frek-1}|t],lst++[char])
  end

  #Tests the question
  def test() do
    decode([{:a, 2}, {:c, 1}, {:b, 3}, {:a, 1}])
  end
end

#Problems with the printing
defmodule Q2 do

  def zip(lst1,lst2) do
    a = length(lst1)
    b = length(lst2)
    if a != b do
      IO.puts("Not the same length")
    else
      zipped(lst1,lst2,[])
    end
  end

  #Base case -> Return the zipped
  def zipped([],[],lst) do
    lst
  end

  #Running case -> just add them together as a tuple
  def zipped([h1|t1],[h2|t2],[]) do
    add = {h1,h2}
    zipped(t1,t2,[{add}])
  end

  #Running case -> just add them together as a tuple
  def zipped([h1|t1],[h2|t2],lst) do
    ziper = {h1,h2}
    zipped(t1,t2,add({ziper},lst))
  end

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


  def test() do
    zip([:a,:b,:c], [1,2,3])
  end
end

#This question was hard
defmodule Q3 do

  #If an empty tree
  def balance(nil) do
    {0,0}
  end

  #If a tree with
  def balance({:node,_,left,right}) do
    #We want the left side and right side and calculate their length and respective imbalances
    {depthL,imbalanceL} = balance(left)
    {depthR,imbalanceR} = balance(right)

    #We get the depth of the tree then + 1
    depth = max(depthL,depthR) + 1

    #The Imbalance the left and right tree depth absolute value of them
    imbalance = max(max(imbalanceL,imbalanceR),abs(depthL-depthR))
     {depth,imbalance}
  end

  def test() do
    tree = {:node,:root,{:node,:L1,nil,nil},{:node,:R1,{:node,:r1l1,nil,nil},nil}}
    balance(tree)
  end
end

defmodule Q4 do

  #Handles Addition
  def eval({:add,expr1,expr2}) do
    eval(expr1) + eval(expr2)
  end

  #Handles multiplication
  def eval({:mul,expr1,expr2}) do
    eval(expr1) * eval(expr2)
  end

  #Handles negative
  def eval({:neg,expr}) do
    -expr
  end

  #Handles regular numbers
  def eval(integer) do
    integer
  end

  def test() do
    eval({:add, {:mul, 2, 3}, {:neg, 2}})
  end
end

defmodule Q5 do

  #Base case ->
  def grey(0) do
    [[]]
  end

  def grey(n) do
    #Generate grey n-1 then reverse the list
    reverse = Enum.reverse(grey(n-1))
    list1 = update(grey(n-1),0)
    list2 = update(reverse,1)

    #This is what returns
    list1 ++ list2
  end

  def update([],_) do
    []
  end

  def update([h|t],int) do
    [[int|h]|update(t,int)]
  end
end

defmodule Q7 do

  #Fib/0 returns a function as an arugment
  def fib() do
    fn() -> fib(1,0) end
  end

  #Fib/2 takes two arguments and returns a function
  def fib(f1, f2) do
    {:ok, f1, fn() -> fib(f1+f2, f1) end}
  end

  def take(inf, 0) do
    {:ok, [], inf}
  end

  def take(inf, n) do
    {:ok, next, cont} = inf.()
    {:ok, rest, cont} = take(cont, n-1)
    {:ok, [next|rest], cont}
  end

  def test() do
    cont = fib()
    {:ok, f1, cont} = cont.()
    {:ok, f2, cont} = cont.()
    {:ok, f3, cont} = cont.()
    {:ok,f4,cont} = cont.()
    [f1,f2,f3,f4]
  end
end

defmodule Q9 do
  def start(user) do
    {:ok, spawn(fn() -> proc(user) end)}
  end

  def proc(user) do
  receive do
    {:process, task} ->
      done = doit(task)
      send(user, done)
      proc(user)
    :quit ->
      :ok
    end
  end
end

defmodule Q9svar do

  def start(user) do
    collector = spawn(fn() -> collector(user, 0) end)
    {:ok, spawn(fn() -> para(collector, 0) end)}
  end

  def para(collector, n) do
    receive do
      {:process, task} ->
        spawn(fn() ->
          done = doit(task)
          send(collector, {:done, n, done})
        end)
        para(collector, n+1)
      :quit ->
        send(collector, :quit)
        :ok
    end
  end

  def collector(user, n) do
    receive do
      {:done, ^n, done} ->
        send(user, done)
        collector(user, n+1)
      :quit ->
        :ok
  end

end
