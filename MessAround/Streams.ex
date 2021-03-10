defmodule Streams do

  @doc """
  The goal of this assigment is that you should practive working with functions as arguments
  and returns values. It also gives insigt into how streams are represented are handled in Elixir
  To begin with we will implmenet a range in and see how we can represent it in a generic way
  We then extend this representation to lazy streams. The interface that we will use will be very
  similar to the Enumerables protocol
  """

  @doc """
  1A ->
    Let's begin with representing a range of integer. We can of course do this by
    a list of integers but that would not be so practical if we are talking about ranges of
    thousands of integer. Why not simply represent a range as a tuple {:range,from,to} where form and to
    are set limits of but are included in the range. Choosing this representation we continue and implement some funciton
    over ranges
  """

  @type range :: {:range,integer(),integer()}


  #If the -> from is the same as the to
  def sumShit({:range,to,to}) do
    to
  end

  #Else just sum all the numbers from "from" to "to".
  def sumShit({:range,from,to}) do
    from + sum({:range,from+1,to})
  end

  @doc """
  We could of course now write arbitrary functions that interate over the integers
  in the range but why not write a generic function that works in the same as foldl/3
  Let's call it reduce.
  """

  #Takes a tuple, an acculator and an function as parameters
  def reduceShit({:range,from,to},acc,operation) do
    if from <= to do
      reduce({:range,from+1,to},operation.(from,acc),operation)
      IO.puts(inspect(acc))
    else
      acc
    end
  end

  @doc """
  The implementation we have gives us the ability to implement arbitrary fold
  operations over ranges.But what if we want to implement a function that
  returns the first n elements of a range. We could of course implement is explicitly:
  """




end
