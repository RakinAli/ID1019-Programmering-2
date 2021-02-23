defmodule Calc do

  #an integer :: {int,n}
  #addition :: {:add,a,b}
  #Subtraction :: {:sub,a,b}
  #Multiplication :: {:mul,a,b}

  #Variables :: {:var,name}
  #Bindings :: {:bind,name,vallue}

  #Evaluates an integer
  def eval({:int,n}) do
    n
  end

  #Handles addition
  def eval({:add,a,b}) do
    eval(a) + eval(b)
  end

    #Handles addition with variables
    def eval({:add,a,b},bindings) do
      eval(a,bindings) + eval(b,bindings)
    end

  #Handles subtraction
  def eval({:sub,a,b}) do
    eval(a) - eval(b)
  end

  #Handles multiplication
  def eval({:mul,a,b}) do
    eval(a) * eval(b)
  end

  def eval({:var, name}, bindings) do
    lookup(name,bindings)
  end


  #Looks up a variable in a binding -> Found
  def lookup(var, [{:bind, var, value} | _] ) do
    value
  end

  #Looks up a variable in a binding -> Not found
  def lookup(var, [_ | rest]) do
    lookup(var,rest)
  end

end
