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
