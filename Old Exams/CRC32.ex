defmodule CRC do

  @doc """
  The task is to implement a Cyclic Redundancy Check using a generator we already have
  First -> Add three zeroes to the tail
  Second -> Check if header starts with zero. If zero -> skip the element
  Third -> Check if
  """

  #This is predefined in the question
  def generator() do
    [1,0,1,1]
  end

  #Here we put the sequence
  def compute([h|t]) do
    #If the length is three then we end the code directly
    n = Enum.count([h|t])
    if n == 3 do
      [h|t]
    else
      #add three zeroes at the tail then we start the recursion
      zeroAdded = add_zero([h|t])
      computee(zeroAdded)
    end
  end

  #Starting case ->
  def computee([h|t]) do
    #If the length is three then we end the code
    IO.puts("start:  #{inspect([h|t])}")
    n = Enum.count([h|t])
    if n == 3 do
      [h|t]
    else
      #1) -> Xor them
      filted = xor([h|t],[1,0,1,1])
      IO.puts("Xor  :  #{inspect(filted)}")

      #2) -> Jump over the zeroes
      zeroJumped = jump_zero(filted)
      IO.puts("Jumped: #{inspect(zeroJumped)}")
      computee(zeroJumped)
    end
  end

  #Adds zero to the list
  def add_zero([h|t]) do
    [h|t]++ [0,0,0]
  end

  #Adds zero to the list
  def add_zero([]) do
    []
  end

  #Checks if the header starts with zero or 1
  def jump_zero([h|t]) do
    n = Enum.count([h|t])
    #If the length is three -> No more jumping zeroes
    if n==3 do
      [h|t]
    #If not -> We can continue checking if there's zeroes or not
    else
      if h == 0 do
        jump_zero(t)
      else
        [h|t]
      end
    end
  end

  #Base case- > If there's only zero -> return an empty list
  def jump_zero([]) do
    []
  end

  def xor([], l) do
    l
  end

  def xor(l, []) do
    l
  end

  def xor([h1 | t1], [h2 | t2]) do
    [:erlang.bxor(h1, h2) | xor(t1, t2)]
  end

  def test() do
    IO.puts("Test 1")
    compute([1,0,1,0,0,0,1,1,0])

    IO.puts("Test2")
    compute([1,1,0,1,0,1,0,1,1,1,0,1,0,0,1,1,0])

  end
end
