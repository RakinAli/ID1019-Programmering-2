defmodule Church do

  #:X -> x-> x
  def to_church(0) do
    fn(_), y -> y end
  end

  #:X -> :X ->
  def to_church(n) do
    fn(f, x) -> f.(to_church(n - 1).(f, x)) end
  end

  #Counts how many f's in f(f(f(f()))) -> In this case 4 f's
  def to_integer(church) do
    church.(fn(x) -> 1 + x end, 0)
  end

  #Takes a numeral and return that is the successor i.e one more.
  def succ(n) do
    fn(f, x) -> f.(n.(f, x)) end
  end

  #Adds n and m
  def add(n, m) do
    fn(f, x) -> n.(f, m.(f, x)) end
  end

  #Multiplies n with m
  def mul(n, m) do
    fn(f, x) -> n.(fn(y) -> m.(f, y) end, x) end
  end

  #Gives a predecessor
  def pred(n) do
    fn(f, x) ->
      ( n.(  # n is a Church numeral
          fn(g) -> fn(h) -> h.(g.(f)) end end,  # apply this function n times
          fn(_) -> x end)  # to this function
      ).(fn(u) -> u end)  # apply it to thee identity function
    end
  end

  def minus(m,n) do
    
  end



end
