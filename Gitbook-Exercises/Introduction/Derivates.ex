defmodule Derivates do

  @type literal() :: {:num, number()}
                | {:var, atom()}

  @type expr() :: {:add, expr(), expr()}
  | {:mul, expr(), expr()}
  | literal()


  #DERIVATES FUNCTION

  #Derivate of a constant
  def deriv({:num, _}, _) do
    {:num, 0}
  end

  #Derivate when there's 1 variable
  def deriv({:var, v}, v) do
    {:num,1}
  end

  #When we are derivating a function without vhe variable
  def deriv({:var, _}, _) do
    {:num,0}
  end

  #dx f(x)*g(x) = f'(x)g(x) + f(x)*g'(x)
  def deriv({:mul, e1, e2}, v) do
   {:add,
   {:mul,deriv(e1,v),e2},
   {:mul,e1,deriv(e2,v)}
  }
  end

  def deriv({:add, e1, e2}, v) do
    {:add,
    deriv(e1,v),
    deriv(e2,v)
    }
  end

  def deriv({:exp,e,{:num,n}},v) do
    {:mul,
    {:mul,{:num,n},{:exp,e,{:num,n-1}}},
    deriv(e,v)
    }
  end

  #Derivate of sin x
  def deriv({:trig,:sin,{:var,v}}v) do
    {:trig,cos{:var,v}}
  end

  def deriv({:trig,:cos,{:var,v}}v) do
    {:trig,:-sin,{:var,v}}
  end

  #SIMPLIFLY FUNCTION

  #Addition
  def simplify({:add,e1,e2}) do
    simplify_add({:add,simplify(e1),simplify(e2)})
  end

  #Multiplication
  def simplify({:mul,e1,e2}) do
    simplify_mul({:mul,simplify(e1),simplify(e2)})
  end

  #FIXA UPP SENARE

  def sim


  #Simplify extensions -> ADDITION

  #If we add with zero
  def simplify_add({:add,{:num,0},{:num,n2}}) do
    n2
  end

  #If we add with zero
  def simplify_add({:add,{:num,n1},{:num,0}}) do
    n1
  end

  #Standard case -> Just take n1 + n2
  def simplify_add({:add,{:num,n1},{:num,n2}}) do
    n1+n2
  end




end
