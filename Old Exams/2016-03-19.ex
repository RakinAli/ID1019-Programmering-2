#Denna tentamen gick åt helvete
defmodule Q21 do

  #Callee case
  def reduce([]) do
    []
  end

  #If the same element
  def reduce([h,h|t]) do
    [h|reduce(t)]
  end

  def reduce([h|t]) do
    [h|reduce(t)]
  end

end

defmodule Q22 do

  #Base case
  def encode([]) do
    []
  end

  #When h is under a-c
  def encode([h|t]) when h<100 do
    [h-3+26|encode(t)]
  end

  def encode([32|rest]) do
    [32|encode(rest)]
  end

  #continues with the rest
  def encode([h|t]) do
    [h-3|encode(t)]
  end
end

defmodule Q23 do

  def trist([]) do
    false
  end

  def trist([{card,_,v}|rest]) do
    case :lists.filter(fn({card,_,n}) -> n == v end, rest) do
      [_,_|_] -> true
      _-> trist(rest)
    end
  end
end

defmodule Q51 do

  #Starts a new process
  def new(value) do
    getter = spawn(fn()->start(value)end)
  end

  #
  def start(oldValue) do
    IO.puts(oldValue)
    receive do
      {:swap,new,from} ->
        send(from,{:ok,oldValue})
      {set,new} ->
        IO.puts("The value has been updated")
        start(new)
    end
  end

  def test() do
    new(10)
    self

  end

end
