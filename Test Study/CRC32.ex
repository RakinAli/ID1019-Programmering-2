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
    compute([h|t],[])
  end

  #Base case -> Return the list
  def compute([],lst) do
    lst
  end

  #Starting case -> We XOR the 4 headers and put them into the list
  def compute([h|t],[]) do
    #First part of the algorithm -> Add zeros to the tail
    add_zero([h|t])

    #Second part of the algo -> Jump the zeroes
    zeroJumped = jump_zero([h|t])

    #Third part of the algorithm -> Xor the 3 headers
    filtered = xor(zeroJumped,generator)
    compute()

  end

  #Adds zero to the list
  def add_zero([h|t]) do
    [h|t]++ [0,0,0]
  end

  #Checks if the header starts with zero or 1
  def jump_zero([h|t]) do
    if h== 0 do
      jump_zero(t)
    else
      [h|t]
    end
  end

  #Base case- > If there's only zero -> return an empty list
  def jump_zero([]) do
    []
  end





end
