defmodule Derivates do

  @type literal() :: {:num, number()}
                | {:var, atom()}

  @type expr() :: {:add, expr(), expr()}
  | {:mul, expr(), expr()}
  | literal()


  #DERIVATES FUNCTION

  #Derivate of a constant
  def deriv({:num, _}, _), do
    {:num, 0}
  end

  #Derivate when there's 1 variable
  def deriv({:var, v}, v), do
    {:num,1}
  end

  #When we are derivating a function without vhe variable
  def deriv({:var, _}, _), do
    {:num,0}
  end

  #dx f(x)*g(x) = f'(x)g(x) + f(x)*g'(x)
  def deriv({:mul, e1, e2}, v), do
   {:add,
   {:mul,deriv(e1,v),e2},
   {:mul,e1,deriv(e2,v)}
  }
  end

  def deriv({:add, e1, e2}, v), do
    {:add,
    deriv(e1,v),
    deriv(e2,v)
    }
  end

  def deriv({:exp,e,{:num,n}}) do
    {:exp,
    {:mul,e,{:num,n}}
    }
  end


  

end
