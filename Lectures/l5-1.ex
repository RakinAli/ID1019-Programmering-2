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
    | {:exp,expr(),literal()}

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

  def deriv({:exp,e,{:num, n}},v) do
    {:mul,
      {:mul,{:num,n},{:exp,e,{:num,n-1}}},
      deriv(e,v)
    }
  end

  #_______________ CALC FUNCTION___________
  def calc({:num,n},_,_) do
    {:num,n}
  end

  def calc({:var,v},v,n) do
    {:num,n}
  end

  def calc({:var,v},_,_) do
    {:var,v}
  end

  def calc({:add,e1,e2},v,n) do
    {:add,calc(e1,v,n),calc(e2,v,n)}
  end

  def calc({:mul,e1,e2},v,n) do
    {:mul,calc(e1,v,n),calc(e2,v,n)}
  end

  def calc({:exp,e1,e2},v,n) do
    {:exp,calc(e1,v,n),calc(e2,v,n)}
  end



  #Tests
  def test1()do
    e = {:add,
    {:mul,{:num,2},{:var,:x}},
    {:num,4}}

    d = deriv(e,:x)
    c = calc(d,:x,5)
    IO.write("expression: #{pprint(e)}\n")
    IO.write("derivative: #{pprint(d)}\n")
    IO.write("Simplified: #{pprint(simplify(d))}\n")
    IO.write("Calculated: #{pprint(simplify(c))}\n")

    :ok

  end

  def test2()do
    e = {:add,
    {:exp,{:var,:x},{:num,3}},
    {:num,4}}

    d = deriv(e,:x)
    c = calc(d,:x,4)
    IO.write("expression: #{pprint(e)}\n")
    IO.write("derivative: #{pprint(d)}\n")
    IO.write("Simplified: #{pprint(simplify(d))}\n")
    IO.write("Calculated: #{pprint(simplify(c))}\n")


    :ok

  end

  #______________ SIMPLYFLY _________________

  #__________ ADDITION_________-
  #Removes the zero
  def simplify_add({:num,0},e2) do
    e2
  end

  #Removes the zero
  def simplify_add(e1,{:num,0}) do
    e1
  end

  #Multiplies by 2
  def simplify_add({:num,n1},{:num,n2}) do
    {:num,n1+n2}
  end

  def simplify_add(e1,e2) do
    {:add,e1,e2}
  end
  #_______________________________

  #________MULTIPLICATION_________

  #Becomes zero
  def simplify_mul({:num,0},_) do
    {:num,0}
  end

  #Becomes zero
  def simplify_mul(_,{:num,0}) do
    {:num,0}
  end

  #Multiplies number
  def simplify_mul({:num,n1},{:num,n2}) do
    {:num,n1*n2}
  end

  #Multiply by 1
  def simplify_mul({:num,1},e2) do
    e2
  end

  #Multiply by 1
  def simplify_mul(e2,{:num,1}) do
    e2
  end

  #General case
  def simplify_mul(e1,e2) do
    {:mul,e1,e2}
  end

   #Simplies exponents. If power by 0 -> always 1
   def simplify_exp(_,{:num,0}) do
    {:num,1}
  end

  #Simplifies exponents. If power by 1 -> always
  def simplify_exp(e,{:num,1}) do
    e
  end

  def simplify_exp({:num,n1},{:num,n2}) do
    {:num,:math.pow(n1,n2)}
  end

  def simplify_exp(e1,e2) do
    {:exp,e1,e2}
  end

  #_________________________________


  #Simplifies addition. If we have + zero then removes the zero
  def simplify({:add,e1,e2})do
    simplify_add(simplify(e1),simplify(e2))
  end

  #Simplies multiplication. If we have *zero then removes that entirely
  def simplify({:mul,e1,e2})do
    simplify_mul(simplify(e1),simplify(e2))
  end

  def simplify({:exp,e1,e2})do
    simplify_exp(simplify(e1),simplify(e2))
  end

  def simplify(e) do
    e
  end

  #___________________________________________

  #Takes an expression and makes it easier to read

  #__________________PRINTER __________________

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

  def pprint({:exp,e1,e2}) do
    "(#{pprint(e1)}) ^ (#{pprint(e2)})"
  end

end
