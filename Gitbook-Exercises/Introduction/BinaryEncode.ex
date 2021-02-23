defmodule Test do

  #A functhat that converts an integer to a binary

  #Calling case
  def to_better(n) do to_better(n, []) end

  #-> If we have zero then just return empty list
  def to_better(0, b) do
    b
  end

  #we divide the number by 2 and check if it has a remainder
  def to_better(n, b) do
    to_better(div(n, 2), [rem(n, 2) | b])
  end

  # A function that converts a binary list to an integer

  #Calling case to to_integer/2
  def to_integer(x) do
    to_integer(reverse(x), 0)
  end

  #Base case -> If the list is mempty
  def to_integer([], n) do
    n
  end

  #Running case - NOT FIXED
  def to_integer([x | r], n) do
    to_integer(r,:math.pow(2,0))
  end

  def test() do
    reverse([1,1,1,0])
  end

  #Reverse -> Calling case
  def reverse(x) do
    reverse(x,[])
  end

  #Reverse -> Base case
  def reverse([],list) do
    list
  end

  #Zero case
  def reverse([],[]) do
    []
  end

  def reverse([h|t],[]) do
    reverse(t,[h])
  end

  #Reverse -> Running case
  def reverse([h|t],list) do
    reverse(t,[h|list])
  end





end
