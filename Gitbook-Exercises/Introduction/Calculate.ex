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

  #Handles subtraction
  def eval({:sub,a,b}) do
    eval(a) - eval(b)
  end

  #Handles multiplication
  def eval({:mul,a,b}) do
    eval(a) * eval(b)
  end



  
  def lookup(var, [{:bind, var, value} | _] ) do
    value
  end

  def lookup(var, [_ | rest]) do
    lookup(var,rest)
  end






end
