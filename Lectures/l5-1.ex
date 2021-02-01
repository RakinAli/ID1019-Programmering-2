defmodule Test do

#__________LECTURE NOTES__________#
  #3x^2 + 2x + pi -> String "3x^2 + 2x + pi
  #We need a Abstract Synstrax Tree

  #                  AST Literals
  # numbers: {:num,124}, {:num,12.4} -> why?
  #So we can do Pattern mathing

  #variables: {:var, :x}....

  #Constants: {:var,:pi}

  #@literal() :: {:number, number()} OR {:var,atom()}

  #                AST expression
  # additions: {:add,{:numb,124},{:var:pi}}
  # multiplication: {:mul, {:num,2}, {:var,:x}}

  #@literal():: {:add,expr(),expr()} same with with mul etc

  #BEDMAS rule -> Think about that -> Use parsing
  # -> Bulding the AST is the job of the parser - not out problem

  #We will use some derivates
  #rule d/dx X = 1
  # dervative of a Constant = 0
  # derivative of f + g = df + dg
  # derivative of f*g = f'g + f*g'
#______________________________________#

  @type literal()::{:num,number()} | {:var,atom()}

  @type expr() :: literal()
    | {:add,expr(),expr()}
    | {:mul,expr(),expr()}

  #Derivative of a number -> always zero
  def deriv({:num,_},_) do
    {:num,0}
  end

  #Derivative of a variable v with respect to v = always 1
  def deriv({:var,v},v) do
    {:num,1}
  end

  #Derivative of a variable without respect to it = always zero
  def deriv({:var,_},_) do
    {:num,0}
  end

  # d/dx(f(x) + g(x)) = f'(x) + g'(x)
  def deriv({:add,e1,e2},v)do
    {:add,deriv(e1,v),deriv(e2,v)}
  end

  #Derivative of f(x)*g(x) = f'(x)g(x) + f(x)g'(x)
  def deriv({:mul,e1,e2},v) do
    {:add,
      {:mul,deriv(e1,v),e2},
      {:mul,e1,deriv(e2,v)}
    }
  end

  #Tests
  def test()do
    e = {:add,
    {:mul,{:num,2},{:var,:x}},
    {:num,4}}

    d = deriv(e,:x)
    IO.write("expression: #{pprint(e)}\n")
    IO.write("derivative: #{pprint(d)}\n")
    :ok

  end

  #Takes an expression and makes it easier to read

  #Makes num easier
  def pprint({:num,n}) do
    "#{n}"
  end

  #Makes variable printing easier
  def pprint({:var,v}) do
    "#{v}"
  end

  #Makes addition printing easier
  def pprint({:add,e1,e2}) do
    "(#{pprint(e1)} + #{pprint(e2)})"
  end

  #Makes multiplication printing
  def pprint({:mul,e1,e2}) do
    "#{pprint(e1)} * #{pprint(e2)}"
  end

end
